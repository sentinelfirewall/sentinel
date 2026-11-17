# Sentinel Firewall - fork of ConfigServer Firewall & Security

⚡ The sudden shutdown of Configserver in 2025 has left a huge gap in our ecosystem. For years, ConfigServer Firewall (CSF) has been the backbone of server security for hosting providers and control panels —stable, feature-rich, and trusted by sysadmins everywhere.

Luckily, *Way to the Web Limited* released the CSF script under the [GPL license](LICENSE.txt).

Soon after, a group of us [SysAdmins](https://github.com/orgs/sentinelfirewall/people) have started Sentinel project — a fork of CSF that is actively maintained, community-driven, and fully compatible as a drop-in replacement for existing servers.

🔧 The mission:
* Keep the features that made CSF indispensable
* Actively patch, improve, and adapt it to modern needs (ipsets to nfset, iptbales to nftables..)
* Build a sustainable, open project for the community

If you’ve relied on CSF in your day-to-day work, this is your chance to shape its future. We’re looking for developers, testers, sysadmins, writers, designers — anyone passionate about keeping servers secure.

👉 Let’s make sure the tool we’ve all depended on doesn’t fade away. Join us in building Sentinel and carry CSF’s legacy forward.


--------

## 📥 Installation
one-liner:
```
cd /root && wget https://github.com/sentinelfirewall/sentinel/raw/refs/heads/main/csf.tgz && tar -xzf csf.tgz && cd csf && sh install.sh
```

manually:
```cd /root
wget https://github.com/sentinelfirewall/sentinel/raw/refs/heads/main/csf.tgz
tar -xzf csf.tgz
cd csf
sh install.sh
```

## Upgrade from CSF

```
wget -O /etc/csf/csf.pl https://gist.githubusercontent.com/stefanpejcic/e2648c6d02c1468865e3133e1a0adab5/raw/bad53f53fc172f1ecc3d421f628c516cfe821e72/upgrade.csf.pl && csf -uf && \
  wget -O /etc/csf/csf.pl https://raw.githubusercontent.com/sentinelfirewall/sentinel/refs/heads/main/csf/csf.pl
```

## Docs

https://sentinelfirewall.github.io/website/docs/intro/
