#!/usr/bin/env bash

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
