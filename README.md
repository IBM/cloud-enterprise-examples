# IBM Cloud

[![Build Status](https://travis.ibm.com/att-cloudnative/ibmcloud-pattern-guide.svg?token=7NEaPtW1LU1ncUWL18Tz&branch=dev)](https://travis.ibm.com/att-cloudnative/ibmcloud-pattern-guide)

## Pattern Guide

This IBM Cloud pattern guide, can be used to help define an outcome aligned to core certification patterns required to demonstrate key capabilities from IBM Cloud and ATT project.

The rendered Learning Journey can be viewed here - [IBM Cloud Pattern Guide](https://pages.github.ibm.com/att-cloudnative/ibmcloud-pattern-guide/)

To update and manage the IBM Cloud Pattern Guide follow these steps.

### Clone the repository

```bash
git clone
```

### Install dependencies

```bash
npm install
```

This will install all the dependencies necessary to run the environment in development mode
and to build and publish the content.

Most notably, this project depends on the following:
(documented in `package.json`):

```bash
npm install -g gatsby
npm install -g gh-pages
```

Having problems installing `node-gyp`? Check [here](https://github.com/nodejs/node-gyp#installation) for some instructions and [here](https://github.com/nodejs/node-gyp/blob/master/macOS_Catalina.md) if you are on macOS 10.15.

### Write content

The content of the Learning Journey is authored through a hybrid of Markdown and
React. The content
itself is primarily provided using Markdown. React components are sprinkled into the Markdown to
provide for a richer and more interactive set of components in the published guide.

To render the content within your local development environment, run the following:

```bash
npm run build
npm run dev
```

### Publish Content

Currently, the content is published to the GitHub pages site through the `gh-pages` branch
using the `gh-pages` npm module. All of the details for handling the publishing are covered within
the deploy script. The deploy can be run using the following:

```bash
npm run build
npm run deploy
```

The result of the `deploy` can be viewed here -[IBM Cloud Pattern Guide](https://pages.github.ibm.com/att-cloudnative/ibmcloud-pattern-guide/)

**Note:** There is a time delay between when the deploy process completes and when the
content is available on the published site.

### Gatsby and Carbon

Get started using with the Gatsby Carbon theme which includes all configuration you might need to build a
beautiful site inspired by the [Carbon Design System](https://www.carbondesignsystem.com).

## Resources

- [Getting Started](https://gatsby-theme-carbon.now.sh/getting-started)
- [Guides](https://gatsby-theme-carbon.now.sh/guides/configuration)
- [Components](https://gatsby-theme-carbon.now.sh/components/markdown)
- [Demo](https://gatsby-theme-carbon.now.sh/demo)
- [Gallery](https://gatsby-theme-carbon.now.sh/gallery)
- [Contributions](https://gatsby-theme-carbon.now.sh/contributions)
