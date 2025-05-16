start-server:
				@docker compose up -d sshserver

stop-server:
				@docker compose down sshserver

ssh-client:
				@ssh -F ./config sshserver

clean:			stop-server
