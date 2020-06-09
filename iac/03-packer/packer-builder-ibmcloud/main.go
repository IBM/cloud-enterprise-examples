package main

import (
	"github.com/hashicorp/packer/packer/plugin"
	"github.com/johandry/packer-builder-ibmcloud/builder/ibmcloud"
)

func main() {
	server, err := plugin.Server()
	if err != nil {
		panic(err)
	}

	server.RegisterBuilder(new(ibmcloud.Builder))
	server.Serve()
}
