default: all

all: kitchen

ubuntu-1604-vbox.box: template.json scripts/provision.sh http/preseed.cfg
	packer validate template.json
	packer build -force -only=ubuntu-1604-vbox template.json

kitchen-vbox: ubuntu-1604-vbox.box
	bundle exec kitchen test vbox

kitchen: kitchen-vbox 

.PHONY: clean
clean:
	-vagrant box remove -f ubuntu-1604 --provider virtualbox
	-rm -fr output-*/ *.box
