docker build -t shawonkanjidev/multi-client:latest -t shawonkanjidev/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t shawonkanjidev/multi-server:latest -t shawonkanjidev/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t shawonkanjidev/multi-worker:latest -t shawonkanjidev/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push shawonkanjidev/multi-client:latest
docker push shawonkanjidev/multi-server:latest
docker push shawonkanjidev/multi-worker:latest

docker push shawonkanjidev/multi-client:$GIT_SHA
docker push shawonkanjidev/multi-server:$GIT_SHA
docker push shawonkanjidev/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shawonkanjidev/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=shawonkanjidev/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=shawonkanjidev/multi-worker:$GIT_SHA
