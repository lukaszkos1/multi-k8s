docker build -t lukaszkos/multi-client:latest -t lukaszkos/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t lukaszkos/multi-server:latest -t lukaszkos/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t lukaszkos/multi-worker:latest -t lukaszkos/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push lukaszkos/multi-client:latest
docker push lukaszkos/multi-server:latest
docker push lukaszkos/multi-worker:latest

docker push lukaszkos/multi-client:$SHA
docker push lukaszkos/multi-server:$SHA
docker push lukaszkos/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=lukaszkos/multi-server:$SHA
kubectl set image deployments/client-deployment client=lukaszkos/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=lukaszkos/multi-worker:$SHA