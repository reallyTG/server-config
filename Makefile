.PHONY: all prl2 prl3 prl4

all:
	ansible-playbook -i hosts site.yml

prl2:
	ansible-playbook -i hosts -l prl2 site.yml

prl3:
	ansible-playbook -i hosts -l prl3 site.yml

prl4:
	ansible-playbook -i hosts -l prl4 site.yml
