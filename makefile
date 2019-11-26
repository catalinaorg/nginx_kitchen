default: all


all: kitchen

xenial64-vbox.box: template.json scripts/provision.sh http/preseed.cfg
	packer validate template.json
	packer build -force -only=xenial64-vbox template.json

kitchen-vbox: xenial64-vbox.box
	bundle exec kitchen test vbox

kitchen: kitchen-vbox 

.PHONY: clean
clean:
	-vagrant box remove -f xenial64 --provider virtualbox
	-rm -fr output-*/ *.box
