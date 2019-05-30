// Copyright 2015 Sorint.lab
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied
// See the License for the specific language governing permissions and
// limitations under the License.

package main

import (
	"os"

	"github.com/coreos/etcd/clientv3"
	"github.com/sorintlab/stolon/cmd/proxy/cmd"
	"google.golang.org/grpc/grpclog"
)

func main() {
	clientv3.SetLogger(
		grpclog.NewLoggerV2WithVerbosity(os.Stderr, os.Stderr, os.Stderr, 0),
	)
	cmd.Execute()
}
