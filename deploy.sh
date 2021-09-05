docker build -t mandicm223/video-react:latest -t mandicm223/video-react:$SHA -f ./react-frontend/Dockerfile ./react-frontend
docker build -t mandicm223/video-express:latest -t mandicm223/video-express:$SHA -f ./express-server/Dockerfile ./express-server
docker build -t mandicm223/video-worker:latest -t mandicm223/video-worker:$SHA -f ./worker/Dockerfile ./worker

docker push mandicm223/video-react:latest
docker push mandicm223/video-express:latest
docker push mandicm223/video-worker:latest

docker push mandicm223/video-react:$SHA
docker push mandicm223/video-express:$SHA
docker push mandicm223/video-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/react-deployment react=mandicm223/video-react:$SHA
kubectl set image deployments/express-deployment express=mandicm223/video-express:$SHA
kubectl set image deployments/worker-deployment worker=mandicm223/video-worker:$SHA