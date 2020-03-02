.PHONY: all prl3 prl4

all:
	ansible-playbook -i hosts site.yml

prl3:
	ansible-playbook -i hosts -l prl3 site.yml

prl4:
	ansible-playbook -i hosts -l prl4 site.yml
