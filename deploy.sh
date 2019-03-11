docker build -t hyedocker/multi-client:latest -t hyedocker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t hyedocker/multi-server:latest -t hyedocker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t hyedocker/multi-worker:latest -t hyedocker/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push hyedocker/multi-client:latest
docker push hyedocker/multi-server:latest
docker push hyedocker/multi-worker:latest

docker push hyedocker/multi-client:$SHA
docker push hyedocker/multi-server:$SHA
docker push hyedocker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=hyedocker/multi-server:$SHA
kubectl set image deployments/client-deployment client=hyedocker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=hyedocker/multi-worker:$SHA