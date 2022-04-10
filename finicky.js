function andSubdomains(patterns) {
  const matchSubdomains = "(^|.*\.)";

  if (!patterns) {
    return /^$/;
  }

  patterns = Array.isArray(patterns) ? patterns : [patterns];

  return patterns.map(pattern => {
    let result = pattern;

    result = result.replace(/[-[\]\/{}()*+?.,\\^$|#\s]/g, "\\$&");
    result = result.replace(/\\\*/g, ".*");

    return new RegExp("^" + matchSubdomains + result + "$", "i");
  });
}

module.exports = {
  defaultBrowser: "Safari",
  rewrite: [
    {
      // Open Slack URLs in Slack
      // Based on https://github.com/johnste/finicky/issues/96#issuecomment-844571182
      match: ['*.slack.com/*'],
      url: ({ url, urlString }) => {
        const teamsMap = {
          // 'subdomain': 'team'
          // 'acmecorp.enterprise': 'T00000001'
          'remote-com': 'TED9HHXU2'
        }

        const subdomain = url.host.slice(0, -10)
        const pathParts = url.pathname.split("/")

        let team, patterns = {}
        if (subdomain != 'app') {
          if (!Object.keys(teamsMap).includes(subdomain)) {
            finicky.log(
              `No Slack team ID found for ${url.host}`,
              `Add the team ID to ~/.finicky.js to allow direct linking to Slack.`
            )
            return url
          }

          team = teamsMap[subdomain]

          if (subdomain.slice(-11) == '.enterprise') {
            patterns = {
              'file': [/\/files\/\w+\/(?<id>\w+)/]
            }
          } else {
            patterns = {
              'file': [/\/messages\/\w+\/files\/(?<id>\w+)/],
              'team': [/(?:\/messages\/\w+)?\/team\/(?<id>\w+)/],
              'channel': [/\/(?:messages|archives)\/(?<id>\w+)(?:\/(?<message>p\d+))?/]
            }
          }
        } else {
          patterns = {
            'file': [
              /\/client\/(?<team>\w+)\/\w+\/files\/(?<id>\w+)/,
              /\/docs\/(?<team>\w+)\/(?<id>\w+)/
            ],
            'team': [/\/client\/(?<team>\w+)\/\w+\/user_profile\/(?<id>\w+)/],
            'channel': [/\/client\/(?<team>\w+)\/(?<id>\w+)(?:\/(?<message>[\d.]+))?/]
          }
        }

        for (let [host, host_patterns] of Object.entries(patterns)) {
          for (let pattern of host_patterns) {
            let match = pattern.exec(url.pathname)
            if (match) {
              let search = `team=${team || match.groups.team}`

              if (match.groups.id) {
                search += `&id=${match.groups.id}`
              }

              if (match.groups.message) {
                let message = match.groups.message
                if (message.charAt(0) == 'p') {
                  message = message.slice(1, 11) + '.' + message.slice(11)
                }
                search += `&message=${message}`
              }

              const output = {protocol: "slack", host, search}
              const outputStr = `${output.protocol}://${output.host}?${output.search}`
              finicky.log(`Rewrote Slack URL ${urlString} to deep link ${outputStr}`)
              return output
            }
          }
        }

        return url
      }
    },
    {
      // Remove trackers
      match: () => true, // Execute rewrite on all incoming urls
      url({ url }) {
        const removeKeysStartingWith = ["utm_", "uta_"]; // Remove all query parameters beginning with these strings
        const removeKeys = ["fblid", "gclid"]; // Remove all query parameters matching these keys

        const search = url.search
          .split("&")
          .map((parameter) => parameter.split("="))
          .filter(([key]) => !removeKeysStartingWith.some((startingWith) => key.startsWith(startingWith)))
          .filter(([key]) => !removeKeys.some((removeKey) => key === removeKey));

        return {
          ...url,
          search: search.map((parameter) => parameter.join("=")).join("&"),
        };
      },
    },
    {
      // Bypass AWS Simple Email Service tracking redirect
      match: finicky.matchHostnames(andSubdomains("awstrack.me")),
      url({ url, urlString }) {
        const outputStr = decodeURIComponent(
          url.pathname
            .split("/")
            .find((part) => part.startsWith("http"))
          )
        finicky.log(`Rewrote AWS tracking redirect ${urlString} to deep link ${outputStr}`)
        return outputStr
      },
    },
    {
      // Bypass Google tracking redirect
      match: "www.google.com/url?*",
      url({ url, urlString }) {
        const outputStr = decodeURIComponent(
          url.search
            .split("&")
            .map((parameter) => parameter.split("="))
            .find(([key]) => key === "q")
            .pop()
        )
        finicky.log(`Rewrote Google tracking redirect ${urlString} to deep link ${outputStr}`)
        return outputStr
      },
    },
  ],
  handlers: [
    {
      match: () => finicky.getKeys().option,
      browser: "Browserosaurus"
    },
    {
      // Open Slack links in Slack
      match: ({ url }) => url.protocol === "slack",
      browser: "/Applications/Slack.app"
    },
    {
      // Open Figma links in Figma
      match: "www.figma.com/file/*",
      browser: "Figma",
    },
    {
      // Open Zoom links in Zoom
      match: andSubdomains("zoom.us/j/*"),
      browser: "us.zoom.xos"
    },
    {
      // Open links from Slack in Chrome
      match: ({ opener }) => opener.bundleId === "com.tinyspeck.slackmacgap",
      browser: "Google Chrome"
    },
    {
      // Open links from Cron calendar app in Chrome
      match: ({ opener }) => opener.path?.includes("Cron.app"),
      browser: "Google Chrome"
    },
    {
      // Open work related links in Chrome
      match: finicky.matchHostnames(andSubdomains([
        "remote.com",
        "niceremote.com",
        "gitlab.com",
        "asana.com",
        "google.com",
        "loom.com",
        "miro.com",
        "notion.so",
        "okta.com",
        "pitch.com",
        "zoom.us",
      ])),
      browser: "Google Chrome"
    },
  ]
}
