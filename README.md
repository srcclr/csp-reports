# [:] CSP Reports

## Description

[Content Security Policy (CSP)](https://en.wikipedia.org/wiki/Content_Security_Policy) is a standard HTTP header that allows web developers to declare allowed sources of resources like images, fonts, styles etc. that can be loaded on a web page. A CSP header can provide security against Cross-Site Scripting (XSS) and other related attacks.

Adding a new CSP header to an existing site can be challenging. The site may already use scripts and resources from a variety of domains and it can be hard to track them. Tracking them will allow the developer to add exceptions to the CSP policy or figure out alternatives for the violating resources. The aim of this project is to provide a simple and easy way for website developers to figure out a sane CSP policy for their site.

For each user we generate a unique URI that can be set in the `report-uri` field of a `Content-Security-Policy-Report-Only` header. Developers can use this header to set an initial policy, violations to the policy are then sent to the `report-uri`. We provide an easy way to monitor and look at violation reports on our [community site](https://open.srcclr.com). This way developers can iteratively refine their policy and once confident they can eventually set the final policy using the `Content-Security-Policy` header.


