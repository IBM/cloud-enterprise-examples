(window.webpackJsonp=window.webpackJsonp||[]).push([[21],{"/V/1":function(e,t,a){"use strict";a.r(t),a.d(t,"_frontmatter",(function(){return o})),a.d(t,"default",(function(){return O}));a("91GP"),a("rGqo"),a("yt8O"),a("Btvt"),a("RW0V"),a("q1tI");var n=a("7ljp"),r=a("013z"),l=a("T0C+");a("qKvR");function i(){return(i=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var a=arguments[t];for(var n in a)Object.prototype.hasOwnProperty.call(a,n)&&(e[n]=a[n])}return e}).apply(this,arguments)}var o={},b=function(e){return function(t){return console.warn("Component "+e+" was not imported, exported, or provided by MDXProvider as global scope"),Object(n.b)("div",t)}},c=b("Tabs"),s=b("Tab"),p=b("PageDescription"),u=b("InlineNotification"),m={_frontmatter:o},d=r.a;function O(e){var t=e.components,a=function(e,t){if(null==e)return{};var a,n,r={},l=Object.keys(e);for(n=0;n<l.length;n++)a=l[n],t.indexOf(a)>=0||(r[a]=e[a]);return r}(e,["components"]);return Object(n.b)(d,i({},m,a,{components:t,mdxType:"MDXLayout"}),Object(n.b)(c,{mdxType:"Tabs"},Object(n.b)(s,{label:"Prerequisites",mdxType:"Tab"},Object(n.b)(p,{mdxType:"PageDescription"},Object(n.b)("p",null,"Prepare to run Terraform to install the CNCF DevOps Tools into an existing IBM Cloud managed kubernetes cluster")),Object(n.b)("p",null,"The ",Object(n.b)(l.a,{name:"env",mdxType:"Globals"})," is installed by an cloud account administrator, who will run the IasC to create the environment in an IBM Cloud account. The scripts will run as the environment administrator’s user. These instructions explain how to configure and run the Terraform (IasC) scripts to create the ",Object(n.b)(l.a,{name:"env",mdxType:"Globals"}),"."),Object(n.b)("p",null,"The following CLI scripts can be used to apply the necessary IAM policies for the Cloud account administrator"),Object(n.b)("ul",null,Object(n.b)("li",{parentName:"ul"},Object(n.b)("a",i({parentName:"li"},{href:""}),"Admin Users Access Control Polices")),Object(n.b)("li",{parentName:"ul"},Object(n.b)("a",i({parentName:"li"},{href:""}),"Environment Users Access Control Polices")),Object(n.b)("li",{parentName:"ul"},Object(n.b)("a",i({parentName:"li"},{href:""}),"Developer User Access Control Polices"))),Object(n.b)(u,{mdxType:"InlineNotification"},Object(n.b)("p",null,Object(n.b)("strong",{parentName:"p"},"Note"),": The Terraform scripts will clean up the cluster to remove any existing that may have been previously installed. You will need to remember to remove any IBM Cloud services that were previously\ncreated and bound to the cluster.")),Object(n.b)("h3",null,"Confirm permissions"),Object(n.b)("p",null,"Optional: To help confirm that the scripts will have the permissions they’ll require, the environment administrator may log into the account and test creating a couple of resources:"),Object(n.b)("ul",null,Object(n.b)("li",{parentName:"ul"},Object(n.b)("a",i({parentName:"li"},{href:"https://cloud.ibm.com/kubernetes/catalog/cluster/create"}),"Create a cluster")," — Make it single-zone, and specify the proper data center and resource group"),Object(n.b)("li",{parentName:"ul"},"Create a namespace in the image registry"),Object(n.b)("li",{parentName:"ul"},Object(n.b)("a",i({parentName:"li"},{href:"https://cloud.ibm.com/catalog/services/cloudant"}),"Create an instance of Cloudant")," — Select a paid plan and specify the proper region and resource group"),Object(n.b)("li",{parentName:"ul"},Object(n.b)("a",i({parentName:"li"},{href:"https://cloud.ibm.com/observe/monitoring/create"}),"Create an instance of Sysdig")," — Select a paid plan and specify the proper region and resource group")),Object(n.b)("p",null,"As long as the user can create these resources successfully the schematics terraform script will be able to apply its state to the cluster.")),Object(n.b)(s,{label:"Schematics",mdxType:"Tab"},Object(n.b)(p,{mdxType:"PageDescription"},Object(n.b)("p",null,"Configure IBM Cloud Schematics with Terraform infrastructure-as-code (IasC) scripts that will install the tools into your IBM Cloud managed cluster")),Object(n.b)("ul",null,Object(n.b)("li",{parentName:"ul"},Object(n.b)("p",{parentName:"li"},"Create a workspace in IBM Schematics service call it ",Object(n.b)("inlineCode",{parentName:"p"},"cloud-native-toolkit")," and place it in your nominate resource group.")),Object(n.b)("li",{parentName:"ul"},Object(n.b)("p",{parentName:"li"},"On the Settings view import your terraform template"),Object(n.b)("pre",{parentName:"li"},Object(n.b)("code",i({parentName:"pre"},{className:"language-bash"}),"https://github.com/ibm-garage-cloud/cloudnative-toolkit\n"))),Object(n.b)("li",{parentName:"ul"},Object(n.b)("p",{parentName:"li"},"select ",Object(n.b)("inlineCode",{parentName:"p"},"terraform_v0.12")," version from the Terraform version drop down")),Object(n.b)("li",{parentName:"ul"},Object(n.b)("p",{parentName:"li"},"click ",Object(n.b)("strong",{parentName:"p"},"Save template information"))))),Object(n.b)(s,{label:"Variables",mdxType:"Tab"},Object(n.b)(p,{mdxType:"PageDescription"},Object(n.b)("p",null,"To support the running of the Terraform for the CNCF installation configure your variables")),Object(n.b)("p",null,"The installation requires a set of terraform variables to be set for your environment. The Terraform assumes that a cluster has already been created and the CNCF tools are installed into an existing cluster."),Object(n.b)("table",null,Object(n.b)("thead",{parentName:"table"},Object(n.b)("tr",{parentName:"thead"},Object(n.b)("th",i({parentName:"tr"},{align:null}),Object(n.b)("strong",{parentName:"th"},"Variable")),Object(n.b)("th",i({parentName:"tr"},{align:null}),Object(n.b)("strong",{parentName:"th"},"Description")),Object(n.b)("th",i({parentName:"tr"},{align:null}),Object(n.b)("strong",{parentName:"th"},"eg. Value")))),Object(n.b)("tbody",{parentName:"table"},Object(n.b)("tr",{parentName:"tbody"},Object(n.b)("td",i({parentName:"tr"},{align:null}),Object(n.b)("inlineCode",{parentName:"td"},"ibmcloud_api_key")),Object(n.b)("td",i({parentName:"tr"},{align:null}),"The API key from IBM Cloud Console that support service creation access writes"),Object(n.b)("td",i({parentName:"tr"},{align:null}),Object(n.b)("inlineCode",{parentName:"td"},"{guid API key from Console}"))),Object(n.b)("tr",{parentName:"tbody"},Object(n.b)("td",i({parentName:"tr"},{align:null}),Object(n.b)("inlineCode",{parentName:"td"},"resource_group_name")),Object(n.b)("td",i({parentName:"tr"},{align:null}),"The name of the resource group where the cluster is created"),Object(n.b)("td",i({parentName:"tr"},{align:null}),Object(n.b)("inlineCode",{parentName:"td"},"dev-team-one"))),Object(n.b)("tr",{parentName:"tbody"},Object(n.b)("td",i({parentName:"tr"},{align:null}),Object(n.b)("inlineCode",{parentName:"td"},"cluster_name")),Object(n.b)("td",i({parentName:"tr"},{align:null}),"The name of the IKS cluster"),Object(n.b)("td",i({parentName:"tr"},{align:null}),Object(n.b)("inlineCode",{parentName:"td"},"dev-team-one-iks-117-vp"))),Object(n.b)("tr",{parentName:"tbody"},Object(n.b)("td",i({parentName:"tr"},{align:null}),Object(n.b)("inlineCode",{parentName:"td"},"cluster_exists")),Object(n.b)("td",i({parentName:"tr"},{align:null}),"Does the cluster exist already"),Object(n.b)("td",i({parentName:"tr"},{align:null}),Object(n.b)("inlineCode",{parentName:"td"},"true"))),Object(n.b)("tr",{parentName:"tbody"},Object(n.b)("td",i({parentName:"tr"},{align:null}),Object(n.b)("inlineCode",{parentName:"td"},"vpc_cluster")),Object(n.b)("td",i({parentName:"tr"},{align:null}),"Is the cluster created in VPC"),Object(n.b)("td",i({parentName:"tr"},{align:null}),Object(n.b)("inlineCode",{parentName:"td"},"true"))))),Object(n.b)("h3",null,"Environment variables"),Object(n.b)("p",null),Object(n.b)("p",null,"Set them based on the existing cluster:"),Object(n.b)("ul",null,Object(n.b)("li",{parentName:"ul"},Object(n.b)("inlineCode",{parentName:"li"},"resource_group_name")," — The existing cluster’s resource group"),Object(n.b)("li",{parentName:"ul"},Object(n.b)("inlineCode",{parentName:"li"},"cluster_exists")," — Set to ",Object(n.b)("inlineCode",{parentName:"li"},"true")," for an existing cluster"),Object(n.b)("li",{parentName:"ul"},Object(n.b)("inlineCode",{parentName:"li"},"cluster_type")," — Specify the existing cluster’s type",Object(n.b)("ul",{parentName:"li"},Object(n.b)("li",{parentName:"ul"},Object(n.b)("strong",{parentName:"li"},"kubernetes")," — Kubernetes"),Object(n.b)("li",{parentName:"ul"},Object(n.b)("strong",{parentName:"li"},"openshift")," — OpenShift v3"),Object(n.b)("li",{parentName:"ul"},Object(n.b)("strong",{parentName:"li"},"ocp3")," — OpenShift v3"),Object(n.b)("li",{parentName:"ul"},Object(n.b)("strong",{parentName:"li"},"ocp4")," — OpenShift v4"),Object(n.b)("li",{parentName:"ul"},Object(n.b)("strong",{parentName:"li"},"crc")," — CodeReady Containers"))),Object(n.b)("li",{parentName:"ul"},Object(n.b)("inlineCode",{parentName:"li"},"cluster_name")," — The existing cluster’s name")),Object(n.b)("p",null),Object(n.b)(u,{mdxType:"InlineNotification"},Object(n.b)("p",null,Object(n.b)("strong",{parentName:"p"},"Note"),": The values for ",Object(n.b)("inlineCode",{parentName:"p"},"resource_group_name")," and ",Object(n.b)("inlineCode",{parentName:"p"},"cluster_name")," can be found on the Resource List\npage in the IBM Cloud Console - ",Object(n.b)("a",i({parentName:"p"},{href:"https://cloud.ibm.com/resources"}),"https://cloud.ibm.com/resources"))),Object(n.b)("p",null)),Object(n.b)(s,{label:"Apply",mdxType:"Tab"},Object(n.b)(p,{mdxType:"PageDescription"},Object(n.b)("p",null,"Apply the Terraform Schematics workspace")),Object(n.b)("ul",null,Object(n.b)("li",{parentName:"ul"},Object(n.b)("p",{parentName:"li"},"Having configured the variables for the workspace you can now apply it"),Object(n.b)(u,{mdxType:"InlineNotification"},Object(n.b)("p",{parentName:"li"},"  ",Object(n.b)("strong",{parentName:"p"},"Note"),": If you run this approach multiple times remember to delete any pre existing cloud services that were created previously"))),Object(n.b)("li",{parentName:"ul"},Object(n.b)("p",{parentName:"li"},"Navigate to the Workspace you have configured ",Object(n.b)("inlineCode",{parentName:"p"},"cloud-native-toolkit"))),Object(n.b)("li",{parentName:"ul"},Object(n.b)("p",{parentName:"li"},"Click on the ",Object(n.b)("strong",{parentName:"p"},"Apply")),Object(n.b)("p",{parentName:"li"},"  Installing the tools into an existing cluster takes about 30 minutes. You can view the workspace logs to see the progress of the execution of the Schematics Terraform scripts"),Object(n.b)(u,{kind:"success",mdxType:"InlineNotification"},Object(n.b)("p",{parentName:"li"},"  You should now have your ",Object(n.b)(l.a,{name:"env",mdxType:"Globals"}),"\nfully provisioned and configured. Enjoy!")))),Object(n.b)("h3",null,Object(n.b)(l.a,{name:"env",mdxType:"Globals"})),Object(n.b)("p",null,"Once the Schematics scripts have finished, you can see the resources that the scripts created in IBM Cloud:"),Object(n.b)("ul",null,Object(n.b)("li",{parentName:"ul"},"In the IBM Cloud console, open the ",Object(n.b)("a",i({parentName:"li"},{href:"https://cloud.ibm.com/docs/overview?topic=overview-ui#dashboardview",title:"Managing resources in the resource list"}),"Resource List")),Object(n.b)("li",{parentName:"ul"},"On the Resource List page, filter by your Resource Group (e.g. ",Object(n.b)("inlineCode",{parentName:"li"},"dev-team-one"),")"),Object(n.b)("li",{parentName:"ul"},"You should see these resources listed:",Object(n.b)("ul",{parentName:"li"},Object(n.b)("li",{parentName:"ul"},Object(n.b)("strong",{parentName:"li"},"Clusters"),": 1, either Kubernetes or OpenShift"),Object(n.b)("li",{parentName:"ul"},Object(n.b)("strong",{parentName:"li"},"Services"),": 2 or so, such as SysDig, LogDNA, etc."))),Object(n.b)("li",{parentName:"ul"},"Select the cluster and open the Kubernetes dashboard or OpenShift web console. You should see:",Object(n.b)("ul",{parentName:"li"},Object(n.b)("li",{parentName:"ul"},"Namespaces: ",Object(n.b)("inlineCode",{parentName:"li"},"tools"),", ",Object(n.b)("inlineCode",{parentName:"li"},"dev"),", ",Object(n.b)("inlineCode",{parentName:"li"},"test"),", and ",Object(n.b)("inlineCode",{parentName:"li"},"staging")),Object(n.b)("li",{parentName:"ul"},"Deployments in the ",Object(n.b)("inlineCode",{parentName:"li"},"tools")," namespace: ",Object(n.b)("inlineCode",{parentName:"li"},"developer-dashboard"),", ",Object(n.b)("inlineCode",{parentName:"li"},"jenkins"),", etc.")))),Object(n.b)("p",null,"To get started open the Developer Dashboard or navigate to the tools using the OpenShift Tools menu."),Object(n.b)("ul",null,Object(n.b)("li",{parentName:"ul"},"To complete the setup install the Developer tools into the IBM Cloud Shell ",Object(n.b)("a",i({parentName:"li"},{href:"/att-cloudnative/ibmcloud-pattern-guide/ci-cd/cloud-native-setup-tools"}),"Cloud Native - Developer Tools"))),Object(n.b)("h3",null,"Possible issues"),Object(n.b)("p",null,"If you find that that the Terraform provisioning has failed, try deleting the workshpace and configuring it again")),Object(n.b)(s,{label:"Post Install",mdxType:"Tab"},Object(n.b)(p,{mdxType:"PageDescription"},Object(n.b)("p",null,"Post Installation steps")),Object(n.b)("ul",null,Object(n.b)("li",{parentName:"ul"},"two of the default tools that were installed ",Object(n.b)("strong",{parentName:"li"},"Artifactory")," and ",Object(n.b)("strong",{parentName:"li"},"ArgoCD")," require some post installation configuration."),Object(n.b)("li",{parentName:"ul"},"Complete these steps documented here for ",Object(n.b)("a",i({parentName:"li"},{href:"cloud-native-setup/artifactory-setup"}),"Artifactory Configuration")),Object(n.b)("li",{parentName:"ul"},"Complete these steps documented here for ",Object(n.b)("a",i({parentName:"li"},{href:"cloud-native-setup/argo-setup"}),"ArgoCD Configuration"))))))}O.isMDXComponent=!0}}]);
//# sourceMappingURL=component---src-pages-ci-cd-cloud-native-setup-index-mdx-008182e15b4a5262144a.js.map