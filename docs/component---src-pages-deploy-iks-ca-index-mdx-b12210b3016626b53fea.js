(window.webpackJsonp=window.webpackJsonp||[]).push([[40],{P7Dx:function(e,a,t){"use strict";t.r(a),t.d(a,"_frontmatter",(function(){return l})),t.d(a,"default",(function(){return b}));t("91GP"),t("rGqo"),t("yt8O"),t("Btvt"),t("RW0V"),t("q1tI");var s=t("7ljp"),o=t("013z");t("qKvR");function n(){return(n=Object.assign||function(e){for(var a=1;a<arguments.length;a++){var t=arguments[a];for(var s in t)Object.prototype.hasOwnProperty.call(t,s)&&(e[s]=t[s])}return e}).apply(this,arguments)}var r,l={},c=(r="InlineNotification",function(e){return console.warn("Component "+r+" was not imported, exported, or provided by MDXProvider as global scope"),Object(s.b)("div",e)}),i={_frontmatter:l},p=o.a;function b(e){var a=e.components,t=function(e,a){if(null==e)return{};var t,s,o={},n=Object.keys(e);for(s=0;s<n.length;s++)t=n[s],a.indexOf(t)>=0||(o[t]=e[t]);return o}(e,["components"]);return Object(s.b)(p,n({},i,t,{components:a,mdxType:"MDXLayout"}),Object(s.b)("p",null,"The cluster autoscaler is available for standard clusters that are set up with public network connectivity. With the ",Object(s.b)("inlineCode",{parentName:"p"},"ibm-iks-cluster-autoscaler")," plug-in, you can scale the worker pools in your IBM Cloud Kubernetes Service cluster automatically to increase or decrease the number of worker nodes in the worker pool based on the sizing needs of your scheduled workloads."),Object(s.b)("h2",null,"Install the cluster autoscaler plug-in using Helm Chart"),Object(s.b)("p",null,"The environment should be set for the cluster which you want to autoscale as explined in ",Object(s.b)("inlineCode",{parentName:"p"},"Environment Setup")," section.\nOnce environment is ready, follow the below steps:"),Object(s.b)("ul",null,Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"Confirm that your IBM Cloud Identity and Access Management credentials are stored in the cluster."),Object(s.b)("pre",{parentName:"li"},Object(s.b)("code",n({parentName:"pre"},{className:"language-bash"}),"kubectl get secrets -n kube-system | grep storage-secret-store\n"))),Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"The cluster autoscaler can scale only worker pools that have the ",Object(s.b)("inlineCode",{parentName:"p"},"ibm-cloud.kubernetes.io/worker-pool-id"),"label. Check whether your worker pool has the required label."),Object(s.b)("pre",{parentName:"li"},Object(s.b)("code",n({parentName:"pre"},{className:"language-bash"}),"\n# To get Cluster name or ID\nibmcloud ks cluster ls\n\n# To get Worker-Pool name or ID for your cluster\nibmcloud ks worker-pool ls -c <cluster_name_or_ID>\n\n# To check Label of the worker-pool\nibmcloud ks worker-pool get --cluster <cluster_name_or_ID> --worker-pool <worker_pool_name_or_ID> | grep Labels\n"))),Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"Install ",Object(s.b)("inlineCode",{parentName:"p"},"Helm v3")," by following the ",Object(s.b)("a",n({parentName:"p"},{href:"https://cloud.ibm.com/docs/containers?topic=containers-helm#install_v3"}),"instructions"),". You can skip this step if you already have helmv3 installed.")),Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"Add and update the Helm repo where the cluster autoscaler Helm chart is."),Object(s.b)("pre",{parentName:"li"},Object(s.b)("code",n({parentName:"pre"},{className:"language-bash"}),"helm repo add iks-charts https://icr.io/helm/iks-charts\nhelm repo update\n"))),Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"Install the cluster autoscaler Helm chart in the ",Object(s.b)("inlineCode",{parentName:"p"},"kube-system")," namespace of your cluster. In the example command, the default worker pool is enabled for autoscaling with the Helm chart installation."),Object(s.b)("pre",{parentName:"li"},Object(s.b)("code",n({parentName:"pre"},{className:"language-bash"}),"helm install ibm-iks-cluster-autoscaler iks-charts/ibm-iks-cluster-autoscaler --namespace kube-system --set workerpools[0].default.max=4,workerpools[0].default.min=2,workerpools[0].default.enabled=true\n")),Object(s.b)("p",{parentName:"li"},"Here, the first workerpool named as default is enabled for autoscaling with maximum number of nodes as 4 and 2 minimum number of worker nodes. To customize and understand more ",Object(s.b)("inlineCode",{parentName:"p"},"--set workerpools")," options, please refer this ",Object(s.b)("a",n({parentName:"p"},{href:"https://cloud.ibm.com/docs/containers?topic=containers-ca#ca_helm"}),"link"),".")),Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"Verify that the installation is successful."),Object(s.b)("ul",{parentName:"li"},Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"Check that the cluster autoscaler pod is in a Running state."),Object(s.b)("pre",{parentName:"li"},Object(s.b)("code",n({parentName:"pre"},{className:"language-bash"}),"kubectl get pods --namespace=kube-system | grep ibm-iks-cluster-autoscaler\n"))),Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"Check that the cluster autoscaler service is created."),Object(s.b)("pre",{parentName:"li"},Object(s.b)("code",n({parentName:"pre"},{className:"language-bash"}),"kubectl get service --namespace=kube-system | grep ibm-iks-cluster-autoscaler\n"))),Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"The worker pool details are added to the cluster autoscaler config map. Verify that the config map is correct by checking that the ",Object(s.b)("inlineCode",{parentName:"p"},"workerPoolsConfig.json")," field is updated and that the ",Object(s.b)("inlineCode",{parentName:"p"},"workerPoolsConfigStatus")," field shows a success message."),Object(s.b)("pre",{parentName:"li"},Object(s.b)("code",n({parentName:"pre"},{className:"language-bash"}),"kubectl get cm iks-ca-configmap -n kube-system -o yaml\n")))))),Object(s.b)(c,{mdxType:"InlineNotification"},"The more detailed instructions are provided at https://cloud.ibm.com/docs/containers?topic=containers-ca#ca_helm . Please follow the link to get more details of each step and to customize the cluster autoscaler settings."),Object(s.b)("h2",null,"Scaling up Worker nodes"),Object(s.b)("p",null,"A pod is considered pending when insufficient compute resources exist to schedule the pod on a worker node. When the cluster autoscaler detects pending pods, the autoscaler scales up your worker nodes to meet the workload resource requests."),Object(s.b)("ul",null,Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"Deploy the application as explained in ",Object(s.b)("inlineCode",{parentName:"p"},"Deploy Application to IKS")," section.")),Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"Create a deployment such that the worker pool runs out of resources and some of the pods will be in pending state which then triggers the cluster autoscaler to scale up the worker pool. Execute the following steps to increase load using ",Object(s.b)("inlineCode",{parentName:"p"},"hpa")," resource."),Object(s.b)("pre",{parentName:"li"},Object(s.b)("code",n({parentName:"pre"},{className:"language-bash"}),"# configure hpa\nkubectl autoscale deployment test --cpu-percent=25 --min=1 --max=25\n\n# modify yaml for ingress subdomain\nsed -i '' s#HOST#<YOUR_INGRESS_SUBDOMAIN># generate-load-ca.yaml  //mac\nOR\nsed -i s#HOST#<YOUR_INGRESS_SUBDOMAIN># generate-load-ca.yaml     //linux\n\nkubectl create -f generate-load-ca.yaml\n")),Object(s.b)(c,{mdxType:"InlineNotification"},Object(s.b)("p",{parentName:"li"},"Check out the ",Object(s.b)("strong",{parentName:"p"},"Horizontal Pod AutoScaling")," section to understand more about ",Object(s.b)("strong",{parentName:"p"},"hpa"),"."))),Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"The above step should result some of the pods in ",Object(s.b)("inlineCode",{parentName:"p"},"pending")," state. Keep checking the following command. "),Object(s.b)("pre",{parentName:"li"},Object(s.b)("code",n({parentName:"pre"},{className:"language-bash"}),"# to check pods and their state\nkubectl get pods\n\n# to check the number of replicas\nkubectl get hpa\n"))),Object(s.b)("li",{parentName:"ul"},Object(s.b)("p",{parentName:"li"},"Verify if cluster autoscaler has triggered using the following command."),Object(s.b)("pre",{parentName:"li"},Object(s.b)("code",n({parentName:"pre"},{className:"language-bash"}),"# if it shows Workers > 1 then Cluster Autoscaler has been triggered successfully\nibmcloud ks worker-pool ls --cluster <cluster_name_or_ID>\n")),Object(s.b)("p",{parentName:"li"},"You can check the IBM Cloud Dashboard to confirm if worker nodes are created to meet the current demand. The dashboard will show something like this snapshot."),Object(s.b)("span",n({parentName:"li"},{className:"gatsby-resp-image-wrapper",style:{position:"relative",display:"block",marginLeft:"auto",marginRight:"auto",maxWidth:"1152px"}}),"\n      ",Object(s.b)("span",n({parentName:"span"},{className:"gatsby-resp-image-background-image",style:{paddingBottom:"35.416666666666664%",position:"relative",bottom:"0",left:"0",backgroundImage:"url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAHCAYAAAAIy204AAAACXBIWXMAABYlAAAWJQFJUiTwAAABY0lEQVQoz22RyW7VQBBF/cP8BlKUBR/AH5AFSLAhq+yyJVkgPQSByMOz/Tz3ZLdtHaocWEFLV7cH1a3u08loPMYGuqmn60VdJ2oxxvyjcTLEYLj94nn9fubqw8ybTzPPZ8s2G9gMiTUjzk5YZ7BmwjnLPM/EGP+jFfbIKd/4/LBz+7hz93VncpF39yvXHyPJ918lT88lRTVQ1ANN21OWJVmWUVc15bmkqiratiXPc86yHrsaN5T4sWJocsa+4fom59XbhuT0I+f07SdF2UloT9sNXOr6KNagtMgOVxRpmlLLWaWNRIWEp1ku8wtjm8FckQzC66ltMN7hrTBaFrZtw3vPtu+46I+1Dn22Dl3vcqYe40Jcd9rBEuaVRGH3AntS8OIhvPCz1h4+CVd9rs5DCH9CXpgu0jwET1gi/WhYhH2ihU6kruH6Ieu6HsXqwyAILpcjSAP0Zrr/V7qnn2WsY5UmvwGPUxNOC554lAAAAABJRU5ErkJggg==')",backgroundSize:"cover",display:"block"}})),"\n  ",Object(s.b)("img",n({parentName:"span"},{className:"gatsby-resp-image-image",alt:"Scalingup Nodes",title:"Scalingup Nodes",src:"/cloud-enterprise-examples/static/41422eafbb71ea452cae1d070e4be85b/3cbba/dashboard-scale-up.png",srcSet:["/cloud-enterprise-examples/static/41422eafbb71ea452cae1d070e4be85b/7fc1e/dashboard-scale-up.png 288w","/cloud-enterprise-examples/static/41422eafbb71ea452cae1d070e4be85b/a5df1/dashboard-scale-up.png 576w","/cloud-enterprise-examples/static/41422eafbb71ea452cae1d070e4be85b/3cbba/dashboard-scale-up.png 1152w","/cloud-enterprise-examples/static/41422eafbb71ea452cae1d070e4be85b/f8f7e/dashboard-scale-up.png 1174w"],sizes:"(max-width: 1152px) 100vw, 1152px",style:{width:"100%",height:"100%",margin:"0",verticalAlign:"middle",position:"absolute",top:"0",left:"0"},loading:"lazy"})),"\n    "),Object(s.b)("p",{parentName:"li"},"It will take few minutes for a new worker node to get ready. You can also follow along with the pod deployment from the command line. You should see the pods transition from pending to running as nodes are scaled up. After sometime all four worker nodes will be up and running. "))),Object(s.b)("h2",null,"Scaling down Worker nodes"),Object(s.b)("p",null,"The cluster autoscaler periodically scans the cluster to adjust the number of worker nodes within the worker pools. If the cluster autoscaler detects underutilized worker nodes, it scales down your worker nodes one at a time so that you have only the compute resources that you need."),Object(s.b)("p",null,"Decrease the load using the following command."),Object(s.b)("pre",null,Object(s.b)("code",n({parentName:"pre"},{className:"language-bash"}),"kubectl delete -f generate-load-ca.yaml\n")),Object(s.b)("p",null,"When the load decreases, the number of pods will also decrease which internally freed up the worker nodes. After a short period of time, the cluster autoscaler detects that your cluster no longer needs all its compute resources and scales down the worker nodes one at a time. Check the Kubernetes dashboard after sometime, you can see the that nodes are getting deleted."),Object(s.b)("span",{className:"gatsby-resp-image-wrapper",style:{position:"relative",display:"block",marginLeft:"auto",marginRight:"auto",maxWidth:"1152px"}},"\n      ",Object(s.b)("span",n({parentName:"span"},{className:"gatsby-resp-image-background-image",style:{paddingBottom:"33.33333333333333%",position:"relative",bottom:"0",left:"0",backgroundImage:"url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAHCAYAAAAIy204AAAACXBIWXMAABYlAAAWJQFJUiTwAAABUklEQVQoz2VRy07EMAzsn3LgL+ADuIHEAYk/2CMHDnwM0rJs2yR9pI80bZKmHezs7olIli3HnsxMsn6cYMYaWjdoW426rmGMwTiO/8KYEV1v8HhwuH/3uHvzeKD6rAxWd4mMl601aXiaJszzDO891nVFWMMlh0CxIsaYatVHlHpF0cZUzy7g9Svi+dMj+zmd0DQtsWvRdR2EEMjzHEVRQAqZ6qqqIKXE8XhMCpTIoRtF+YxKFun+6fCLl48GmaBFTWBaawzDQOANhBRQSkHUEqUo0fd9WmJwrhmc7SnLMs1JVcN2BbaFAL8JbLQ2yXXOYdu2JHsliW4PmJcZfFguy+fDltxypN40ewxmplmS3LLhxqSPWJYleWTpAQYPbiEbdFrk4N6+72mOH7j47WCsI4wp9TNLzJjdDZBZ3ICj82jIM/Y2ECD3bsxYib/2mJm9fuYfIK0ThtSOB90AAAAASUVORK5CYII=')",backgroundSize:"cover",display:"block"}})),"\n  ",Object(s.b)("img",n({parentName:"span"},{className:"gatsby-resp-image-image",alt:"ScalingDown Nodes",title:"ScalingDown Nodes",src:"/cloud-enterprise-examples/static/3e5143e1ee0eb456594616478426fef1/3cbba/dashboard-scale-down.png",srcSet:["/cloud-enterprise-examples/static/3e5143e1ee0eb456594616478426fef1/7fc1e/dashboard-scale-down.png 288w","/cloud-enterprise-examples/static/3e5143e1ee0eb456594616478426fef1/a5df1/dashboard-scale-down.png 576w","/cloud-enterprise-examples/static/3e5143e1ee0eb456594616478426fef1/3cbba/dashboard-scale-down.png 1152w","/cloud-enterprise-examples/static/3e5143e1ee0eb456594616478426fef1/b5a46/dashboard-scale-down.png 1178w"],sizes:"(max-width: 1152px) 100vw, 1152px",style:{width:"100%",height:"100%",margin:"0",verticalAlign:"middle",position:"absolute",top:"0",left:"0"},loading:"lazy"})),"\n    "),Object(s.b)("p",null,"We setup 2 as minimum number of worker nodes, it means that the cluster autoscaler does not scale down below two worker nodes  even if you remove the workload that requests the amount. Hence check the dashboard after sometime, it will show as below snapshot."),Object(s.b)("span",{className:"gatsby-resp-image-wrapper",style:{position:"relative",display:"block",marginLeft:"auto",marginRight:"auto",maxWidth:"1152px"}},"\n      ",Object(s.b)("span",n({parentName:"span"},{className:"gatsby-resp-image-background-image",style:{paddingBottom:"27.77777777777778%",position:"relative",bottom:"0",left:"0",backgroundImage:"url('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABQAAAAGCAYAAADDl76dAAAACXBIWXMAABYlAAAWJQFJUiTwAAABMklEQVQY02VQu07DQBD09/FVNFDyFVAR0VBS0EQKFUUaFCESx3GMn/f04+5ie7i9KBSw0mp1u7NzOxPpdoDQEmVTgTGGqqqglILW+l9KpWF6hdd1h5sng7tng+tHg9VH53c03KAREVBp5cFnkrZtMQwDrLUwxvypFtPJYB07PCxHLN5G3C8n7AqHuLBYrCyi7zyHkp5QynAZXdk0TahCCHDGw4xzHvpCSPQtBxzHbDlOfQOcJF7eOa5uBaLPzQZFUaAoy7BU1zWyLEOSJCjrCl/xFqxhSNMUh8MhYNL06PE1jlmO7S5G7ef7fQJeHRFlHqC7Lkjt+x7zPAd51ssbMUF6XzAj9C5BFlA45377TND+gCgmaeQdpScO5nuJREhg8nccPfU0haQPL5X6hDn7bsL7B534xpca8PCzAAAAAElFTkSuQmCC')",backgroundSize:"cover",display:"block"}})),"\n  ",Object(s.b)("img",n({parentName:"span"},{className:"gatsby-resp-image-image",alt:"Dashboard",title:"Dashboard",src:"/cloud-enterprise-examples/static/6c37e4b5c38a79b09ad8ac05fb9451b7/3cbba/dashboard-iks.png",srcSet:["/cloud-enterprise-examples/static/6c37e4b5c38a79b09ad8ac05fb9451b7/7fc1e/dashboard-iks.png 288w","/cloud-enterprise-examples/static/6c37e4b5c38a79b09ad8ac05fb9451b7/a5df1/dashboard-iks.png 576w","/cloud-enterprise-examples/static/6c37e4b5c38a79b09ad8ac05fb9451b7/3cbba/dashboard-iks.png 1152w","/cloud-enterprise-examples/static/6c37e4b5c38a79b09ad8ac05fb9451b7/7ce68/dashboard-iks.png 1188w"],sizes:"(max-width: 1152px) 100vw, 1152px",style:{width:"100%",height:"100%",margin:"0",verticalAlign:"middle",position:"absolute",top:"0",left:"0"},loading:"lazy"})),"\n    "))}b.isMDXComponent=!0}}]);
//# sourceMappingURL=component---src-pages-deploy-iks-ca-index-mdx-b12210b3016626b53fea.js.map