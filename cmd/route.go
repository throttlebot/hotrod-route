// Copyright (c) 2017 Uber Technologies, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package cmd

import (
	"net"
	"strconv"

	"github.com/spf13/cobra"

	"gitlab.com/kelda-hotrod/hotrod-route/route"
)

// routeCmd represents the route command
var routeCmd = &cobra.Command{
	Use:   "route",
	Short: "Starts Route service",
	Long:  `Starts Route service.`,
	RunE: func(cmd *cobra.Command, args []string) error {
		server := route.NewServer(
			net.JoinHostPort(routeOptions.serverInterface, strconv.Itoa(routeOptions.serverPort)),
		)
		return logError(server.Run())
	},
}

var (
	routeOptions struct {
		serverInterface string
		serverPort      int
	}
)

func init() {
	RootCmd.AddCommand(routeCmd)

	routeCmd.Flags().StringVarP(&routeOptions.serverInterface, "bind", "", "0.0.0.0", "interface to which the Route server will bind")
	routeCmd.Flags().IntVarP(&routeOptions.serverPort, "port", "p", 8083, "port on which the Route server will listen")
}
