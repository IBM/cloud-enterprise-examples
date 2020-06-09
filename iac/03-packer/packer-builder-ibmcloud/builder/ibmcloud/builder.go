//go:generate struct-markdown
//go:generate mapstructure-to-hcl2 -type Config

// The ibmcloud package contains a packer.Builder implementation that
// builds AMIs for IBM Cloud VSI.

package ibmcloud

import (
	"context"
	"time"

	"github.com/hashicorp/hcl/v2/hcldec"
	"github.com/hashicorp/packer/common"
	"github.com/hashicorp/packer/helper/communicator"
	"github.com/hashicorp/packer/helper/multistep"
	"github.com/hashicorp/packer/packer"
	"github.com/hashicorp/packer/template/interpolate"
)

// BuilderID is the unique ID for this builder
const BuilderID = "packer.builder.ibmcloud"

// Config is required for the builder configuration
type Config struct {
	common.PackerConfig `mapstructure:",squash"`
	Comm                communicator.Config `mapstructure:",squash"`

	ICAPIKey                       string   `mapstructure:"ic_api_key"`
	ImageName                      string   `mapstructure:"image_name"`
	ImageDescription               string   `mapstructure:"image_description"`
	ImageType                      string   `mapstructure:"image_type"`
	BaseImageID                    string   `mapstructure:"base_image_id"`
	BaseOsCode                     string   `mapstructure:"base_os_code"`
	UploadToDatacenters            []string `mapstructure:"upload_to_datacenters"`
	InstanceName                   string   `mapstructure:"instance_name"`
	InstanceDomain                 string   `mapstructure:"instance_domain"`
	InstanceFlavor                 string   `mapstructure:"instance_flavor"`
	InstanceLocalDiskFlag          bool     `mapstructure:"instance_local_disk_flag"`
	InstanceCPU                    int      `mapstructure:"instance_cpu"`
	InstanceMemory                 int64    `mapstructure:"instance_memory"`
	InstanceDiskCapacity           int      `mapstructure:"instance_disk_capacity"`
	DatacenterName                 string   `mapstructure:"datacenter_name"`
	PublicVlanID                   int64    `mapstructure:"public_vlan_id"`
	InstanceNetworkSpeed           int      `mapstructure:"instance_network_speed"`
	ProvisioningSSHKeyID           int64    `mapstructure:"provisioning_ssh_key_id"`
	InstancePublicSecurityGroupIds []int64  `mapstructure:"public_security_groups"`
	RawStateTimeout                string   `mapstructure:"instance_state_timeout"`
	StateTimeout                   time.Duration

	ctx interpolate.Context
}

// Builder implements the packer.Builder interface
type Builder struct {
	config Config
	runner multistep.Runner
}

// ConfigSpec implements the ConfigSpec method from the packer.Builder interface.
// ConfigSpec returns the hcl object spec used to configure the builder.
func (b *Builder) ConfigSpec() hcldec.ObjectSpec { return b.config.FlatMapstructure().HCL2Spec() }

// Prepare implements the Prepare method from the packer.Builder interface.
// Prepare returns a list of variables that will be made accessible to users
// during the provision methods, a list of warnings along with any errors that
// occurred while preparing.
func (b *Builder) Prepare(raws ...interface{}) ([]string, []string, error) {
	return nil, nil, nil
}

// Run implements the Run method from the packer.Builder interface.
// Run is where the actual build should take place.
func (b *Builder) Run(ctx context.Context, ui packer.Ui, hook packer.Hook) (packer.Artifact, error) {
	return nil, nil
}
