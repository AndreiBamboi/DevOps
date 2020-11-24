if [[ $(docker volume ls | grep portainer_data) ]]; then
  echo "Data volume for persistence already exist, will continue with deployment"
else
  docker volume create portainer_data
  echo "Missing volume for persistence and created the portainer_data volume"
fi
docker run -d -p 8000:8000 -p 9000:9000 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce
echo "Portainer container started"
