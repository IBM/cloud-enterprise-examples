import React from 'react';
import { HomepageBanner, HomepageCallout } from 'gatsby-theme-carbon';
import HomepageTemplate from 'gatsby-theme-carbon/src/templates/Homepage';
import { calloutLink } from './Homepage.module.scss';

import Carbon from '../../images/personphone.jpg';

const BannerText = () => <h1>Cloud Patterns<br/>Guide</h1>;

const FirstLeftText = () => <p>IBM Cloud</p>;

const FirstRightText = () => (
  <p>
      This guide contains patterns to help an enterprise customer leverage key capabilities of IBM Cloud, including Infrastructure as code, auto-scaling, logging, monitoring, and CI/CD.
  </p>
);

const SecondLeftText = () => <p>Cloud Patterns</p>;

const SecondRightText = () => (
  <p>
      The patterns are focused  on ....
    <a
      className={calloutLink}
      href="https://cloud.ibm.com/"
    >
      IBM Cloud →
    </a>
  </p>
);


const customProps = {
  Banner: <HomepageBanner renderText={BannerText} image={Carbon} />,
  FirstCallout: (
    <HomepageCallout
      backgroundColor="#030303"
      color="white"
      leftText={FirstLeftText}
      rightText={FirstRightText}
    />
  ),
  SecondCallout: (
    <HomepageCallout
      leftText={SecondLeftText}
      rightText={SecondRightText}
      color="white"
      backgroundColor="#061f80"
    />
  ),
};

// spreading the original props gives us props.children (mdx content)
function ShadowedHomepage(props) {
  return <HomepageTemplate {...props} {...customProps} />;
}

export default ShadowedHomepage;
