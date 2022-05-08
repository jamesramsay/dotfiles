const base64 = require('~/.config/finicky/base64.js');

function param(url, k) {
  return url.search
    .split("&")
    .map((parameter) => parameter.split("="))
    .find(([key]) => key === k)
    .pop()
}

const amazon = {
  // Amazon AWS Simple Email Service
  //
  //   https://xyz.r.us-west-2.awstrack.me/L0/{url}/1/abc/123
  //
  match: finicky.matchHostnames(andSubdomains("awstrack.me")),
  url({ url, urlString }) {
    const outputStr = decodeURIComponent(
      url.pathname
      .split("/")
      .find((part) => part.startsWith("http"))
      );
    finicky.log(`Rewrote AWS SES tracker ${urlString} to direct link ${outputStr}`);
    return outputStr;
  }
};

const google = {
  // Google
  //
  //   https://www.google.com/url?{url}
  //
  match: "www.google.com/url?*",
  url({ url, urlString }) {
    const outputStr = decodeURIComponent(param(url, "q"));
    finicky.log(`Rewrote Google tracker ${urlString} to direct link ${outputStr}`);
    return outputStr;
  }
};

const mandrill = {
  // Mandrill
  //
  //   https://mandrillapp.com/track/click/abc123/example.com?p={payload}
  //   payload (JSON): { "p": { "url": "https://example.com/destination" } }
  //
  match: ["mandrillapp.com/*"],
  url({ url, urlString }) {
    const payload = JSON.parse(Base64.decode(param(url, "p")))
    const outputStr = JSON.parse(payload.p).url
    finicky.log(`Rewrote Mandrill tracker ${urlString} to direct link ${outputStr}`)
    return outputStr
  }
};

module.exports = { rewrite: [
  amazon,
  google,
  mandrill,
]};

