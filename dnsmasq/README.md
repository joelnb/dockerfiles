# Dnsmasq

A containerised [Dnsmasq](http://www.thekelleys.org.uk/dnsmasq/doc.html) with the [hostess](https://github.com/cbednarski/hostess) command included for easier management of DNS hostnames.

## Example Usage

```bash
docker run -d --name dnsmasq -p 53:53 -p 53:53/udp joelnb/dnsmasq
docker exec -it dnsmasq hostess add example.com 1.2.3.4
```
