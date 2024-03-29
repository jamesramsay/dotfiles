const decode = require('~/.config/finicky/decode.js');
const slack = require('~/.config/finicky/slack.js');

function andSubdomains(patterns) {
  const matchSubdomains = "(^|.*\.)";

  if (!patterns) return /^$/;

  patterns = Array.isArray(patterns) ? patterns : [patterns];
  return patterns.map(pattern => {
    let result = pattern;

    result = result.replace(/[-[\]\/{}()*+?.,\\^$|#\s]/g, "\\$&");
    result = result.replace(/\\\*/g, ".*");

    return new RegExp("^" + matchSubdomains + result + "$", "i");
  });
}

const googleMeetApp = {
  browser: ({ urlString }) => ({
    name: "Google Chrome",
    // profile: "Profile 1",
    args: [
      `--app-id=kjgfgldnnfoeklkmfkjfagphfepbbdan`, // Google Meet PWA
      `--app-launch-url-for-shortcuts-menu-item=${urlString}`,
    ],
  }),
}

module.exports = {
  defaultBrowser: "Safari",
  rewrite: [...decode.rewrite, slack.rewrite],
  handlers: [
    {
      match: () => finicky.getKeys().option,
      browser: "Velja"
    },
    {
      // Open Slack links in Slack
      match: ({ url }) => url.protocol === "slack",
      browser: "/Applications/Slack.app"
    },
    {
      // Open Figma file links in Figma
      match: "www.figma.com/file/*",
      browser: "Figma",
    },
    {
      // Open Zoom meeting links in Zoom
      match: andSubdomains("zoom.us/j/*"),
      browser: "us.zoom.xos"
    },
    {
      // Open Google Meet meeting links in Meet PWA
      match: finicky.matchHostnames(["meet.google.com"]),
      ...googleMeetApp,
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
        "figma.com",
      ])),
      browser: "Google Chrome"
    },
  ]
}
