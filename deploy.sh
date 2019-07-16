docker build -t twokdavey/multi-client:latest -t twokdavey/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t twokdavey/multi-server:latest -t twokdavey/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t twokdavey/multi-worker:latest -t twokdavey/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push twokdavey/multi-client:latest
docker push twokdavey/multi-server:latest
docker push twokdavey/multi-worker:latest

docker push twokdavey/multi-client:$SHA
docker push twokdavey/multi-server:$SHA
docker push twokdavey/multi-worker:$SHA

kubectl apply -f K8s

kubectl set image deployments/server-deployment server=twokdavey/multi-server:$SHA
kubectl set image deployments/client-deployment client=twokdavey/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=twokdavey/multi-worker:$SHA