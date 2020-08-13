module.exports = {
  siteMetadata: {
    title: "IBM Cloud",
    description: "IBM Cloud Pattern Guide",
    keywords: "gatsby,theme,carbon",
  },
  plugins: [
    "gatsby-theme-carbon",
    "gatsby-transformer-json",
    {
      resolve: `gatsby-source-filesystem`,
      options: {
        name: "data",
        path: "./src/data",
      },
    },
    {
      resolve: `gatsby-plugin-google-analytics`,
      options: {
        trackingId: "UA-155887541-2",
      },
    },
  ],
  pathPrefix: "/cloud-enterprise-examples",
};

// Meanwhile it's automated, set this pathPrefix to generate the delivered web site:
// pathPrefix: "/cloud-enterprise-examples",
