(window.webpackJsonp=window.webpackJsonp||[]).push([[76],{lhtg:function(e,t,n){"use strict";n.r(t),n.d(t,"_frontmatter",(function(){return o})),n.d(t,"default",(function(){return m}));n("91GP"),n("rGqo"),n("yt8O"),n("Btvt"),n("RW0V"),n("q1tI");var a=n("7ljp"),r=n("013z");n("qKvR");function i(){return(i=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var a in n)Object.prototype.hasOwnProperty.call(n,a)&&(e[a]=n[a])}return e}).apply(this,arguments)}var o={},c=function(e){return function(t){return console.warn("Component "+e+" was not imported, exported, or provided by MDXProvider as global scope"),Object(a.b)("div",t)}},s=c("PageDescription"),l=c("AnchorLinks"),b=c("AnchorLink"),p=c("InlineNotification"),d={_frontmatter:o},h=r.a;function m(e){var t=e.components,n=function(e,t){if(null==e)return{};var n,a,r={},i=Object.keys(e);for(a=0;a<i.length;a++)n=i[a],t.indexOf(n)>=0||(r[n]=e[n]);return r}(e,["components"]);return Object(a.b)(h,i({},d,n,{components:t,mdxType:"MDXLayout"}),Object(a.b)(s,{mdxType:"PageDescription"},Object(a.b)("p",null,"Sharing SSH key between projects")),Object(a.b)(l,{small:!0,mdxType:"AnchorLinks"},Object(a.b)(b,{mdxType:"AnchorLink"},"Create the SSH Key Pair"),Object(a.b)(b,{mdxType:"AnchorLink"},"Using the IBM Cloud CLI to create the SSH Key"),Object(a.b)(b,{mdxType:"AnchorLink"},"Using Terraform to create the SSH Key"),Object(a.b)(b,{mdxType:"AnchorLink"},"Use the created SSH key"),Object(a.b)(b,{mdxType:"AnchorLink"},"Clean up")),Object(a.b)("p",null,"Terraform code in the example projects provided in this pattern creates, modifies and destroys the SSH key. However, you may want to use your own SSH key or create, modify and destroy it using a different method. Having a SSH key shared between projects is also good practice to follow. This chapter describes how to manage a SSH key outside of the example project Terraform code."),Object(a.b)("h2",null,"Create the SSH Key Pair"),Object(a.b)("p",null,"Before creating the SSH key in IBM Cloud you need to have a SSH key pair in your system. You can create the key pair using the ",Object(a.b)("inlineCode",{parentName:"p"},"ssh-keygen")," command. If you use the default parameters it generates the SSH Key Pairs in the files ",Object(a.b)("inlineCode",{parentName:"p"},"~/.ssh/id_rsa.pub")," and ",Object(a.b)("inlineCode",{parentName:"p"},"~/.ssh/id_rsa"),". Read ",Object(a.b)("a",i({parentName:"p"},{href:"https://cloud.ibm.com/docs/vpc?topic=vpc-ssh-keys"}),"create the SSH key pair")," to know more about the command ",Object(a.b)("inlineCode",{parentName:"p"},"ssh-keygen")," and the different parameters you can use."),Object(a.b)("p",null,"You can create the SSH Key on IBM Cloud on different ways, here we’ll explain two: Using the IBM Cloud CLI and using Terraform."),Object(a.b)("h2",null,"Using the IBM Cloud CLI to create the SSH Key"),Object(a.b)("p",null,"Make sure you have installed ",Object(a.b)("inlineCode",{parentName:"p"},"ibmcloud")," and the ",Object(a.b)("inlineCode",{parentName:"p"},"infrastructure-service")," plugin targeting it to Gen 2. Then login to your account using the ",Object(a.b)("inlineCode",{parentName:"p"},"ibmcloud login")," command. The ",Object(a.b)("a",i({parentName:"p"},{href:"/att-cloudnative/ibmcloud-pattern-guide/iac/setup-environment"}),"Setup Environment")," page explain how to get this ready."),Object(a.b)("p",null,"List the existing SSH Keys using the following command to not use one of the used key names:"),Object(a.b)("pre",null,Object(a.b)("code",i({parentName:"pre"},{className:"language-bash"}),"ibmcloud is keys\n")),Object(a.b)("p",null,"To create your SSH Key execute the command ",Object(a.b)("inlineCode",{parentName:"p"},"ibmcloud is key-create KEY_NAME (KEY | @KEY_FILE)"),". Assuming you’ll take the public SSH key from ",Object(a.b)("inlineCode",{parentName:"p"},"~/.ssh/id_rsa.pub")," and name the key ",Object(a.b)("inlineCode",{parentName:"p"},"schematics-test-key"),", the command would be like this:"),Object(a.b)("pre",null,Object(a.b)("code",i({parentName:"pre"},{className:"language-bash"}),"ibmcloud is key-create schematics-test-key @~/.ssh/id_rsa.pub\n")),Object(a.b)("p",null,"If something went wrong with the creation you can update the key name or delete the SSH key with the following commands respectively. The key ID ",Object(a.b)("inlineCode",{parentName:"p"},"00000000-0000-0000-0000-000000000000")," is fake, get the correct Key ID using the ",Object(a.b)("inlineCode",{parentName:"p"},"ibmcloud is keys")," command."),Object(a.b)("pre",null,Object(a.b)("code",i({parentName:"pre"},{className:"language-bash"}),"ibmcloud is key-update 00000000-0000-0000-0000-000000000000 --name my-new-name\nibmcloud is key-delete 00000000-0000-0000-0000-000000000000 -f\n")),Object(a.b)(p,{mdxType:"InlineNotification"},Object(a.b)("h6",null,"Where can I learn more?"),Object(a.b)("p",null,"Refer to the documentation the ",Object(a.b)("a",i({parentName:"p"},{href:"https://cloud.ibm.com/docs/cli?topic=vpc-infrastructure-cli-plugin-vpc-reference#keys"}),"Keys")," in the VPC Infrastructure Service plugin. Or, use the CLI help with ",Object(a.b)("inlineCode",{parentName:"p"},"ibmcloud is KEY-CMD --help")," where ",Object(a.b)("inlineCode",{parentName:"p"},"KEY-CMD")," can be ",Object(a.b)("inlineCode",{parentName:"p"},"key"),", ",Object(a.b)("inlineCode",{parentName:"p"},"keys"),", ",Object(a.b)("inlineCode",{parentName:"p"},"key-create"),", ",Object(a.b)("inlineCode",{parentName:"p"},"key-delete")," or ",Object(a.b)("inlineCode",{parentName:"p"},"key-update"),"."),Object(a.b)("p",null,"Notice that some documentation refers to the command ",Object(a.b)("inlineCode",{parentName:"p"},"ibmcloud sl security sshkey-*"),", this document is to manage the SSH Keys for the Classic Infrastructure or Gen 1.")),Object(a.b)("h2",null,"Using Terraform to create the SSH Key"),Object(a.b)("p",null,"A pre-requisite for using Terraform is to complete the ",Object(a.b)("a",i({parentName:"p"},{href:"/att-cloudnative/ibmcloud-pattern-guide/iac/setup-environment"}),"environment setup"),". For the steps below, it’s required to have Terraform installed, the IBM Cloud Provider installed and the variable ",Object(a.b)("inlineCode",{parentName:"p"},"IC_API_KEY")," exported with the API Key to access your IBM Cloud account."),Object(a.b)("p",null,"In the ",Object(a.b)("a",i({parentName:"p"},{href:"/att-cloudnative/ibmcloud-pattern-guide/iac/getting-started-terraform"}),"Getting Started with Terraform")," we made Terraform code to create a SSH Key for our simple instance. We can reuse that code. Create a directory named ",Object(a.b)("inlineCode",{parentName:"p"},"ssh-key")," for the following Terraform code:"),Object(a.b)("pre",null,Object(a.b)("code",i({parentName:"pre"},{className:"language-bash"}),"mkdir ssh-key\ncd ssh-key\n")),Object(a.b)("pre",null,Object(a.b)("code",i({parentName:"pre"},{className:"language-hcl",metastring:"path=main.tf",path:"main.tf"}),'provider "ibm" {\n  generation         = 2\n  region             = "us-south"\n}\n\nvariable "public_key_file"  { default = "~/.ssh/id_rsa.pub" }\nlocals {\n  public_key    = file(pathexpand(var.public_key_file))\n}\n\nvariable "ssh_key_name" {}\n\nresource "ibm_is_ssh_key" "iac_shared_ssh_key" {\n  name       = var.ssh_key_name\n  public_key = local.public_key\n}\n\noutput "id" {\n  value = ibm_is_ssh_key.iac_shared_ssh_key.id\n}\noutput "ibm_cloud_url" {\n  value = ibm_is_ssh_key.iac_shared_ssh_key.resource_controller_url\n}\n')),Object(a.b)("p",null,"Execute ",Object(a.b)("inlineCode",{parentName:"p"},"terraform init"),", then execute the following commands to create or update the key (you will be prompted for the key name because there is no default set for ssh_key_name variable in the code):"),Object(a.b)("pre",null,Object(a.b)("code",i({parentName:"pre"},{className:"language-bash"}),"terraform plan\nterraform apply\n")),Object(a.b)("p",null,"To destroy the key just execute ",Object(a.b)("inlineCode",{parentName:"p"},"terraform destroy")),Object(a.b)(p,{mdxType:"InlineNotification"},Object(a.b)("h6",null,"Where can I know more?"),Object(a.b)("p",null,"Read the web documentation for the ",Object(a.b)("a",i({parentName:"p"},{href:"https://cloud.ibm.com/docs/terraform?topic=terraform-vpc-gen2-resources#ssh-key"}),"ibm_is_ssh_key")," resource of the IBM Cloud Provider.")),Object(a.b)("h2",null,"Use the created SSH key"),Object(a.b)("p",null,"To make the Terraform code in all the examples of the IaC pattern use the recently created SSH Key we need to add the following code the files ",Object(a.b)("inlineCode",{parentName:"p"},"variables.tf")," and ",Object(a.b)("inlineCode",{parentName:"p"},"main.tf")," like so:"),Object(a.b)("pre",null,Object(a.b)("code",i({parentName:"pre"},{className:"language-hcl",metastring:"path=variables.tf",path:"variables.tf"}),'variable "ssh_key_name" {}\n')),Object(a.b)("p",null,"All the variables related to the SSH Key were replaced by just one ",Object(a.b)("inlineCode",{parentName:"p"},"ssh_key_name")," which is going to store the name of the recently created SSH Key."),Object(a.b)("pre",null,Object(a.b)("code",i({parentName:"pre"},{className:"language-hcl",metastring:"path=main.tf",path:"main.tf"}),'data "ibm_is_ssh_key" "shared_ssh_key" {\n  name = var.ssh_key_name\n}\n\nresource "ibm_is_instance" "iac_instance" {\n  ...\n  keys = [ data.ibm_is_ssh_key.shared_ssh_key.id ]\n  ...\n}\n')),Object(a.b)("p",null,"In the ",Object(a.b)("inlineCode",{parentName:"p"},"main.tf")," remove all the code to create the SSH Key and insert the data source ",Object(a.b)("inlineCode",{parentName:"p"},"ibm_is_ssh_key")," to get the information from the shared SSH Key. The data source requires the SSH Key name which is stored in the variable ",Object(a.b)("inlineCode",{parentName:"p"},"ssh_key_name"),". Also, remove any SSH key variable in the ",Object(a.b)("inlineCode",{parentName:"p"},"variables.tf")," file."),Object(a.b)("p",null,"The ",Object(a.b)("inlineCode",{parentName:"p"},"ibm_is_instance.iac_instance")," instance use a similar code to get the SSH Key ID, but instead it uses the data source ",Object(a.b)("inlineCode",{parentName:"p"},"ibm_is_ssh_key.shared_ssh_key"),", notice the prefix ",Object(a.b)("inlineCode",{parentName:"p"},"data."),"."),Object(a.b)("h2",null,"Clean up"),Object(a.b)("p",null,"If you’d like to destroy the shared SSH Key just need to execute the command:"),Object(a.b)("pre",null,Object(a.b)("code",i({parentName:"pre"},{className:"language-bash"}),"terraform destroy\n")),Object(a.b)("p",null,"If the SSH key is being used by other resources IBM Cloud will complain and won’t let you delete the key. Make sure no resource is using the key in order to delete it."))}m.isMDXComponent=!0}}]);
//# sourceMappingURL=component---src-pages-iac-schematics-ssh-keys-index-mdx-5be76ec4e93d7067a0ee.js.map