import React from 'react';
import ResourceLinks from 'gatsby-theme-carbon/src/components/LeftNav/ResourceLinks';

const links = [
/*
  {
    title: 'IBM Cloud',
    href: 'https://www.ibm.com/cloud',
  },
  {
    title: 'IBM Cloud Paks',
    href: 'https://www.ibm.com/cloud/paks/',
  },
  {
    title: 'IBM Cloud VMWare',
    href: 'https://www.ibm.com/cloud/vmware',
  },
  {
    title: 'IBM Code Patterns',
    href: 'https://developer.ibm.com/depmodels/cloud/patterns/',
  },
  {
    title: 'IBM Garage Method',
    href: 'https://www.ibm.com/garage/method',
  },
*/
];

// shouldOpenNewTabs: true if outbound links should open in a new tab
const CustomResources = () => <ResourceLinks shouldOpenNewTabs links={links} />;

export default CustomResources;
