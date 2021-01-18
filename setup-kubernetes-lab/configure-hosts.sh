master_1=$(grep "master-1" /etc/hosts)
master_2=$(grep "master-2" /etc/hosts)
worker_1=$(grep "worker-1" /etc/hosts)
worker_2=$(grep "worker-2" /etc/hosts)
load_balancer=$(grep "load-balancer" /etc/hosts)

if [ -z "$master_1" ]
then
  echo ""; echo "# Kubernetes hosts" >> /etc/hosts
  echo "192.168.5.11  master-1" >> /etc/hosts
fi

if [ -z "$master_2" ]
then
  echo "192.168.5.12  master-2" >> /etc/hosts
fi

if [ -z "$worker_1" ]
then
  echo "192.168.5.21  worker-1" >> /etc/hosts
fi

if [ -z "$worker_2" ]
then
  echo "192.168.5.22  worker-2" >> /etc/hosts
fi

if [ -z "$load_balancer" ]
then
  echo "192.168.5.30  load-balancer" >> /etc/hosts
fi