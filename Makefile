help:
	@echo "Available commands:"
	@echo "  bootstrap"
	@echo "  update"
	@echo "  checkout"
	@echo "  develop"
	@echo "  copy-frameworks"
	@echo "  update-workflow"

bootstrap:
	@carthage bootstrap --use-ssh
