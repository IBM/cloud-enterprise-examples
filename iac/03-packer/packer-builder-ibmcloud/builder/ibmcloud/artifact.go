package ibmcloud

type Artifact struct {
	imageName      string
	imageId        string
	datacenterName string
	client         *IBMCloudClient
}
