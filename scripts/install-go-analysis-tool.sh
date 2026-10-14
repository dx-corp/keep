#!/usr/bin/env bash
set -euo pipefail

# Keep analyzer versions fixed while updating their Go export-data reader.
package=$1
version=$2
tools_version=$3
export GOBIN=${GOBIN:-$(go env GOPATH)/bin}
export GOTOOLCHAIN=${GOTOOLCHAIN:-$(go env GOVERSION)}
workspace=$(mktemp -d)
trap 'rm -rf "$workspace"' EXIT
cd "$workspace"
go mod init keep-analysis-tool
go get "$package@$version" "golang.org/x/tools@$tools_version"
go install "$package"
