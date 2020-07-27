#!/usr/bin/env bash

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
cat <<EOH
USAGE: $0

The intention of this script is to release the content from the *dev* branch of
*github.ibm.com/att-cloudnative/ibmcloud-pattern-guide* to the *gh-pages* branch
of *github.com/iBM/cloud-enterprise-examples*.

You should have in the same directory a directory with the cloned repository
github.ibm.com/att-cloudnative/ibmcloud-pattern-guide on the branch dev, and a
directory with the cloned repository github.com/iBM/cloud-enterprise-examples on
the branch gh-pages, where this script is located. The cloud-enterprise-examples
directory must be named: cloud-enterprise-examples_gh-pages.

Like so:
.
├── cloud-enterprise-examples_gh-pages
└── ibmcloud-pattern-guide

When the script is executed, all is published and you may review the content at:
https://ibm.github.io/cloud-enterprise-examples/
EOH
fi

echo "Building the web site"
cd  ../ibmcloud-pattern-guide/
sed -i.bkp 's|pathPrefix: "/att-cloudnative/ibmcloud-pattern-guide"|pathPrefix: "/cloud-enterprise-examples"|' gatsby-config.js
rm -rf .cache public
npm run build
mv gatsby-config.js.bkp gatsby-config.js

echo "Importing the built web site"
cd ../cloud-enterprise-examples_gh-pages/
rm -rf __tmp
mkdir __tmp
mv * __tmp
cp -R ../ibmcloud-pattern-guide/public .
mv public/* .
rmdir public

echo "Publishing the web site"
git add .
git commit -m "Update web site"
git push

echo "Validation"
open https://ibm.github.io/cloud-enterprise-examples/
