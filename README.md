# install

```bash
curl https://raw.githubusercontent.com/MioYvo/php_node_scripts/master/install.sh -o install.sh && bash install.sh
```

ubuntu 1404:
```bash
curl https://raw.githubusercontent.com/MioYvo/php_node_scripts/master/install_ubuntu1404.sh -o install.sh && bash install.sh
```

### walk free

```bash
curl https://raw.githubusercontent.com/MioYvo/php_node_scripts/master/install_v2ray.sh -o install_v2ray.sh && bash install_v2ray.sh
```

## anti DDoS attack

> http://keithmo.me/post/2018/08/25/conntrack-tuning/

```bash
sudo curl https://raw.githubusercontent.com/MioYvo/php_node_scripts/master/90-conntrack.conf -o /etc/sysctl.d/90-conntrack.conf && sudo sysctl -p /etc/sysctl.d/90-conntrack.conf
```

* command to check conntrack:  `sudo sysctl -a | grep conntrack` 

  ```bash
  root@cloud:~# sudo sysctl -a | grep conntrack
  net.netfilter.nf_conntrack_acct = 0
  net.netfilter.nf_conntrack_buckets = 4096
  net.netfilter.nf_conntrack_checksum = 1
  net.netfilter.nf_conntrack_count = 15439
  net.netfilter.nf_conntrack_events = 1
  net.netfilter.nf_conntrack_expect_max = 60
  net.netfilter.nf_conntrack_generic_timeout = 600
  net.netfilter.nf_conntrack_helper = 1
  net.netfilter.nf_conntrack_icmp_timeout = 10
  net.netfilter.nf_conntrack_log_invalid = 0
  net.netfilter.nf_conntrack_max = 16384
  net.netfilter.nf_conntrack_tcp_be_liberal = 0
  net.netfilter.nf_conntrack_tcp_loose = 1
  net.netfilter.nf_conntrack_tcp_max_retrans = 3
  net.netfilter.nf_conntrack_tcp_timeout_close = 10
  net.netfilter.nf_conntrack_tcp_timeout_close_wait = 10
  net.netfilter.nf_conntrack_tcp_timeout_established = 600
  net.netfilter.nf_conntrack_tcp_timeout_fin_wait = 10
  net.netfilter.nf_conntrack_tcp_timeout_last_ack = 10
  net.netfilter.nf_conntrack_tcp_timeout_max_retrans = 300
  net.netfilter.nf_conntrack_tcp_timeout_syn_recv = 5
  net.netfilter.nf_conntrack_tcp_timeout_syn_sent = 5
  net.netfilter.nf_conntrack_tcp_timeout_time_wait = 10
  net.netfilter.nf_conntrack_tcp_timeout_unacknowledged = 300
  net.netfilter.nf_conntrack_timestamp = 0
  net.netfilter.nf_conntrack_udp_timeout = 30
  net.netfilter.nf_conntrack_udp_timeout_stream = 180
  net.nf_conntrack_max = 16384
  ```

  if `nf_conntrack_count` >=  `nf_conntrack_max` , you need to fix it or the server will die.

* `nf_conntrack_max` = `nf_conntrack_buckets` * 4, you may need to change `nf_conntrack_max` after downloading from repo.

* flush all exists conntracks: `sudo apt install -y conntrack && conntrack -F` 