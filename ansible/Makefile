
install:
	@export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
	@export ANSIBLE_HOST_KEY_CHECKING=False
	# to use the GNU tar version
	@export PATH="/usr/local/opt/gnu-tar/libexec/gnubin:$PATH"
	@ansible-playbook playbook.yaml -i inventory.yaml
