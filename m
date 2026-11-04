Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.67.198.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818341;
	b=A4yHRS09wAxcwmEc5lI3aijvFEJ7BKn3T+9u7+IEVYqW50ERjpmTX9JUWJIt75BFiFRb
	 WxP0inJ1kssLmlTrS5pG+I7V5cteEa+rY98uU1L6YXpVmEC+wnuLActDoNecm51lgOQZF
	 oG+eHaG4XDvxhbQtM44rd2ZEIhvfvwgSc9PY0DqbpM9qxAn+NiJg+WLqfVX3m46cMhOcH
	 hWPLt0gREBViN0muuxi20LoSp8EcmXey3qyuVRuNHWxTq13/ukIYcjGQtEbmuoPS32+xQ
	 ywmB37NULF115WrueSRLz9oX3JTmLOepLf1HHQUHOWjL6JuSgSDY91x9rmjzfqukj3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818341;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Subject:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type:Lines:
	 X-Last-TLS-Session-Version;
	bh=L6DOQvCWsFl2rdEGgj10GJbDJ4G/LaHHD2IQKLl8pjk=;
	b=MVJOH9zo4juhRz853f6bC+4j2bBChR9zvSBWmXpYekuyLD1kySOTFWjhfTZOkc7wsN8B
	 JVGUng3/w7h8/TzxHICG1PzlqEiLnpYhGP4W1YActgbhAnB+fdBhkFjP9qS/KxpWvbDde
	 2+cw9pzmGRyL/qDbaE4TARKq3gwU258lFU/ivoPNUw4hIH5l+KHK73Rz73zmh5zERLzJT
	 OWgfabG2ddCcK8wg88DxNUtvvRWJxGSY3qaLdXIdtUj18lBPa3qxJgK+9znPzF0OeDgZG
	 emy+GiSyAOL/99WyY+wMIrTWrRiTV46sPsvz6U5I3sslDi5REpqJfqTXLqxZnqjT5TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=soulintheshell.com;
	spf=pass smtp.mailfrom=soulintheshell.com;
	dkim=pass header.d=soulintheshell.com header.i=@soulintheshell.com header.a=rsa-sha256 header.s=dkim header.b=AEoh+NI3;
	arc=none smtp.remote-ip=82.67.198.80
Received: from mail.soulintheshell.com (mail.soulintheshell.com [82.67.198.80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C79606A32C
	for <audit@vger.kernel.org>; Wed,  4 Nov 2026 18:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86C79606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soulintheshell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soulintheshell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=soulintheshell.com header.i=@soulintheshell.com header.a=rsa-sha256 header.s=dkim header.b=AEoh+NI3
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1E2C42894B;
	Wed, 04 Nov 2026 19:52:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=soulintheshell.com;
	s=dkim; t=1793818332; h=from:subject:date:message-id:to:mime-version:content-type;
	bh=L6DOQvCWsFl2rdEGgj10GJbDJ4G/LaHHD2IQKLl8pjk=;
	b=AEoh+NI3CZzf6wa7kDKWxnOAM9CpZ866CTm7r3QDxdOhAhTBiL9Cu6ICVwZ3HYsfvaH5fw
	VibxuDGGza4F8WV0uVH1CprJr2imlzGpozj+DOEgzwXqMlBl2acYPIaBti7v+toOl8IuZv
	LaLeE0JKN5L8OHa81oeqYbkW5EXNP327+HTtTDtEjhHQFhMh+u2xnT8hs2FMUlhxZYS48Q
	GJEUi2eM2uB/dQB0YGwjdHvkfD4JSrGgYNVjpHipw4qnAk+OSR7FnpXKRda4uBEAUSdd1Y
	TNiSO1ZenToxMzSpKchIX4k2ngFdJ5cJ96JnRq8jYxWhwC6wMUS/nLP9OgdmfQ==
From: seth@soulintheshell.com
To: audit@vger.kernel.org, Steve Grubb <sgrubb@redhat.com>
Subject: Failure to set a watch on a non existing directory
Date: Wed, 04 Nov 2026 19:50:15 +0100
Message-ID: <8733tgfn2w.fsf@soulintheshell.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-Last-TLS-Session-Version: TLSv1.3


Hello,

I reported a behavior that seemed anormal to the auditd maintainer:

https://lists.linux-audit.osci.io/archives/list/linux-audit@lists.linux-audit.osci.io/thread/KOPL2QPINU6F6WVSKN7U3LRLVIXEQYLZ/

The behavior is the impossibility to make a watch on a directory with
`auditctl -F dir=$path` while it is possible with `auditctl -w $path`.

This is problematic as directories may not exists yet when auditd is
initialized (eg: from kernel command line), and the `-w` rules are
marked as deprecated by auditctl.

Here a few tests that illustrate the problem:

- nonexisting path

#+begin_src bash
auditctl -a always,exit -F arch=b64 -F path=/nonexisting_path -F perm=wa
auditctl -a always,exit -F path=/nonexisting_path -F perm=wa
auditctl -l
#+end_src

#+RESULTS:
: perm used without an arch is slower
: perm used without an arch is slower
: -a always,exit -F arch=b64 -S open,bind,truncate,ftruncate,rename,mkdir,rmdir,creat,link,unlink,symlink,chmod,fchmod,chown,fchown,lchown,mknod,acct,swapon,quotactl,setxattr,lsetxattr,fsetxattr,removexattr,lremovexattr,fremovexattr,openat,mkdirat,mknodat,fchownat,unlinkat,renameat,linkat,symlinkat,fchmodat,fallocate,renameat2,openat2 -F path=/nonexisting_path -F perm=wa
: -w /nonexisting_path -p wa

- nonexisting_dir

This will error:

#+begin_src bash
auditctl -a always,exit -F dir=/nonexisting_dir -F perm=wa -k nonexisting
#+end_src

#+RESULTS:
: perm used without an arch is slower
: perm used without an arch is slower
: Error sending add rule data request (No such file or directory)
: There was an error while processing parameters

#+begin_src bash
auditctl -a always,exit -F arch=b64 -F dir=/nonexisting_dir -F perm=wa -k nonexisting_dir
auditctl -l
#+end_src

#+RESULTS:
: Error sending add rule data request (No such file or directory)
: There was an error while processing parameters

Steve Grubb suggested that the issue may be to watch at /, but I don't think so:

#+begin_src bash
auditctl -a always,exit -F arch=b64 -F dir=/root/.config/nonexisting_dir -F perm=wa -k nonexisting_dir
#+end_src

#+RESULTS:
: Error sending add rule data request (No such file or directory)
: There was an error while processing parameters

This will not error:

#+begin_src bash
auditctl -w /root/.config/nonexisting_dir -F perm=wa -k nonexisting_dir
#+end_src

#+RESULTS:
: Old style watch rules are slower
: perm used without an arch is slower
: perm used without an arch is slower
: -w /root/.config/nonexisting_dir -p rwxa -p wa -k nonexisting_dir


Additionally here is quote from Steve Grubb about tracing the execution
of auditctl:

#+begin_quote
rule goes into the kernel:
sendto(4, [{nlmsg_len=1080, nlmsg_type=AUDIT_ADD_RULE, 
nlmsg_flags=NLM_F_REQUEST|NLM_F_ACK, nlmsg_seq=2, nlmsg_pid=0}, 
"\x04\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"...], 
1080, 0, {sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, 12) = 1080

Answer back:
recvfrom(4, [{nlmsg_len=1100, nlmsg_type=NLMSG_ERROR, nlmsg_flags=0, 
nlmsg_seq=2, nlmsg_pid=270500}, {error=-ENOENT, msg=[{nlmsg_len=1080, 
nlmsg_type=AUDIT_ADD_RULE, nlmsg_flags=NLM_F_REQUEST|NLM_F_ACK, nlmsg_seq=2, 
nlmsg_pid=0}, 
"\x04\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"...]}], 
8988, MSG_PEEK|MSG_DONTWAIT, {sa_family=AF_NETLINK, nl_pid=0, 
nl_groups=00000000}, [12]) = 1100

Message the user:
write(2, "Error sending add rule data requ"..., 63Error sending add rule data 
request (No such file or directory)) = 63

The kernel is returning ENOENT. It doesn't matter which form of watch. But 
what I tested yesterday is different:

auditctl -a always,exit -F path=/tmp/nonexitent -F perm=wa -k nonexistent

into the kernel:
sendto(4, [{nlmsg_len=1084, nlmsg_type=AUDIT_ADD_RULE, 
nlmsg_flags=NLM_F_REQUEST|NLM_F_ACK, nlmsg_seq=2, nlmsg_pid=0}, 
"\x04\x00\x00\x00\x02\x00\x00\x00\x03\x00\x00\x00\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"...], 
1084, 0, {sa_family=AF_NETLINK, nl_pid=0, nl_groups=00000000}, 12) = 1084

Answer back no error
recvfrom(4, [{nlmsg_len=36, nlmsg_type=NLMSG_ERROR, nlmsg_flags=NLM_F_CAPPED, 
nlmsg_seq=2, nlmsg_pid=271266}, {error=0, msg={nlmsg_len=1084, 
nlmsg_type=AUDIT_ADD_RULE, nlmsg_flags=NLM_F_REQUEST|NLM_F_ACK, nlmsg_seq=2, 
nlmsg_pid=0}}], 8988, MSG_PEEK|MSG_DONTWAIT, {sa_family=AF_NETLINK, nl_pid=0, 
nl_groups=00000000}, [12]) = 36

It does take paths that do not exist. So, there is a difference in behavior 
based on whether it is a path or directory. That might be worth the kernel 
folks looking deeper into.
#+end_quote


-Seth
