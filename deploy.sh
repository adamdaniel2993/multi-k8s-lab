docker build -t adamdanielf/multi-client:latest -t adamdanielf/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t adamdanielf/multi-server:latest -t adamdanielf/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t adamdanielf/multi-worker:latest -t adamdanielf/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push adamdanielf/multi-client:latest
docker push adamdanielf/multi-server:latest
docker push adamdanielf/multi-worker:latest

docker push adamdanielf/multi-client:$SHA
docker push adamdanielf/multi-server:$SHA
docker push adamdanielf/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=adamdanielf/multi-server:$SHA
kubectl set image deployments/client-deployment client=adamdanielf/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=adamdanielf/multi-worker:$SHA