Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5718335BDA
	for <audit@vger.kernel.org>; Tue,  9 Sep 2025 13:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757423475; cv=none; b=MGzPCmMvYECAEk9iP3rBheRssbgcl29NCiyytzLM6WBYOSBISEG68RU5n7HHMGMn08HHxlSoh9bxUL9oaE06JCA+xxaKQV3W6LNPlNuTpwJmWLTQrPA1CPBF24lYH4FZG+MBM1DCBwaTlxfOhrDdk9miLonzIKZiDkJ7JjC/xmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757423475; c=relaxed/simple;
	bh=Zo3oH4aw0tiSXOUVsgBT9EB9o0z8d/2riNIK+49I9S8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mv9VhJQWUzHPYOcq20uGnLT6ocddilDzYln0Aa7oGvgYI4ERAIdu6NbHDMWRMz8o+yJJhKafkjeH6DGyQcCg59bm5YjPfInXT673Loil77G7rqwiME6YaBWzLBO3IZlQT2UP0cqEA4uSF1skWNhl31JQfDqn4Dgsgox5hSwV5/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ef/R4DrD; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ef/R4DrD"
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D3C6C3F687
	for <audit@vger.kernel.org>; Tue,  9 Sep 2025 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757423462;
	bh=mTARHUNH6YPuN2/2Pw5N85BTAXOgi/Y6NWg4iRpTdcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=Ef/R4DrDaTEPuviXTMb0yDYNgToLODEuTSrk7m9DGQiwviLWMc1lzM1KXCd8CEyLY
	 rRSjx9ir51l5622h9XLdWioDvC6CA9y7QMUAshsgpj4GOfkm5fAHmn3YsCLDPN0wOy
	 yC522+uj3wveGlHF+IjILEL/NC1MBuoypQIauQc2RAkyq0hzb2JvjCOl+cLRrEGVR1
	 NXz1niJ5T11coJSB3+yUc1wR7b8aNdeZ65RRZhx6brf5E6l7mvPsD7NQJ/Cdn0MYoY
	 tUeo/V+4vVgraxPJ4/bI5y+sW5r0a/grGriFRBlmBlpAwkmpcTFlWe8gfr5Xybg5AY
	 WbbNu9Tlc29/w==
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-772537d9f4aso5129131b3a.2
        for <audit@vger.kernel.org>; Tue, 09 Sep 2025 06:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757423461; x=1758028261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTARHUNH6YPuN2/2Pw5N85BTAXOgi/Y6NWg4iRpTdcE=;
        b=jcN3G6qrMaX7OyD5t+/m8lozNSwiZvTdqxrzNu2N4XpxE9+KKkH2oLircTLfVbvOSB
         9eZb/dzU2UJyGgD9FSUSuOjK0qKE3v790vgXwF54vnKi1xCN5+n+P4hHmpcIceqeMSbZ
         BjEcvsv3LhFPTbG9gSfMVLrHaVOSNI6CXqT8pkYOa6zOl9FBtGSfEFF/6Bvhs2OkR1rJ
         0uJkg8rplqaXRizNllIsfJrrNLO1OSEjz855nbgSgB3S6mM3u9/gqXI/lfM8xCJmX9IA
         5DH84o3GGlZ5AlFS13JQfUPwU1P+nubboLHHpKUE6Yk9yXW9zspno/h19E1tNJvbQ1Wq
         zMCg==
X-Forwarded-Encrypted: i=1; AJvYcCW91TDhrty73Z3NjKtEtbXGzA/y+R+aIwVVlDEpzhIbItlOkBSZ9LClUAiEMT1dGdUuQr2hPw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0PcsZXUg8Kdwq+UlqCxtmqQWP6QzjOTZe1p2YQEoRh4OpFoF
	5DNZni8eOxDbLIiTEjMFyXKSS+jLayyOey0bLOd4SIqXbZkQoHfMnqBjJH53RKVxF/t69hfQbnl
	gdwvl19xFFIQ1WWrYJqCFPc32oc37jJCN2KjC7n0Uihk6J++mCbC+1PCv8mo42Ht37DPGz/Tg
X-Gm-Gg: ASbGncsVLwtJ23X7i/iR/7ubr81Jk+BNmP8siTKzEBbdHms6So7ZgDbH/0/s4PMrrgU
	d42kqF99PSPhUtSWTV82lmm9lEUD8UTnvZWNthbz9M1mc0aK6Lgx/tK08Z34T6bjJyvR+NXCumY
	pCErFzMV68wFQmgI1UgkZktiiYi+oSxUI0M3/5fUQ45spiRXmL7cMnwKBjBGu4+cyBTt/QoZBup
	RN79gI2gQWBYVemOW4HZ0TjSqqVcCkqwZPTcH6rvFv9roPfRr7Lslqc2Ex/f1aVpzg2KNvJj/m8
	1yu17dq4BtOAoYLTPb84Oxp7oLbofwicQe8l5/ROXefQ1I9KztKKoIj40CL/oidMPgTmUIbbVw2
	UXbDHMaM=
X-Received: by 2002:a05:6a00:1821:b0:772:499e:99c4 with SMTP id d2e1a72fcca58-7742dddbe77mr15427273b3a.18.1757423461178;
        Tue, 09 Sep 2025 06:11:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9luBLssO1ocG8bZoCNKhOLSOO/E7cpZTqVelHzSs0SjLcBreTUD1zt4mInD7HeDgyEKmFpg==
X-Received: by 2002:a05:6a00:1821:b0:772:499e:99c4 with SMTP id d2e1a72fcca58-7742dddbe77mr15427222b3a.18.1757423460643;
        Tue, 09 Sep 2025 06:11:00 -0700 (PDT)
Received: from noble-c.lxd (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-774660e4dcfsm2171452b3a.18.2025.09.09.06.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 06:10:59 -0700 (PDT)
From: Gerald Yang <gerald.yang@canonical.com>
To: Casey Schaufler <casey@schaufler-ca.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: gerald.yang.tw@gmail.com
Subject: [PATCH] Audit: Fix skb leak when audit rate limit is exceeded
Date: Tue,  9 Sep 2025 13:10:52 +0000
Message-ID: <20250909131056.3395574-1-gerald.yang@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When configuring a small audit rate limit in
/etc/audit/rules.d/audit.rules:
-a always,exit -F arch=b64 -S openat -S truncate -S ftruncate
-F exit=-EACCES -F auid>=1000 -F auid!=4294967295 -k access -r 100

And then repeatedly triggering permission denied as a normal user:
while :; do cat /proc/1/environ; done

We can see the messages in kernel log:
  [ 2531.862184] audit: rate limit exceeded

The unreclaimable slab objects start to leak quickly. With kmemleak
enabled, many call traces appear like:
unreferenced object 0xffff99144b13f600 (size 232):
  comm "cat", pid 1100, jiffies 4294739144
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 8540ec4f):
    kmemleak_alloc+0x4a/0x90
    kmem_cache_alloc_node+0x2ea/0x390
    __alloc_skb+0x174/0x1b0
    audit_log_start+0x198/0x3d0
    audit_log_proctitle+0x32/0x160
    audit_log_exit+0x6c6/0x780
    __audit_syscall_exit+0xee/0x140
    syscall_exit_work+0x12b/0x150
    syscall_exit_to_user_mode_prepare+0x39/0x80
    syscall_exit_to_user_mode+0x11/0x260
    do_syscall_64+0x8c/0x180
    entry_SYSCALL_64_after_hwframe+0x78/0x80

This shows that the skb allocated in audit_log_start() and queued
onto skb_list is never freed.

In audit_log_end(), each skb is dequeued from skb_list and passed
to __audit_log_end(). However, when the audit rate limit is exceeded,
__audit_log_end() simply prints "rate limit exceeded" and returns
without processing the skb. Since the skb is already removed from
skb_list, audit_buffer_free() cannot free it later, leading to a
memory leak.

Fix this by freeing the skb when the rate limit is exceeded.

Signed-off-by: Gerald Yang <gerald.yang@canonical.com>
---
 kernel/audit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index bd7474fd8d2c..89530ddf3807 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2615,8 +2615,10 @@ static void __audit_log_end(struct sk_buff *skb)
 
 		/* queue the netlink packet */
 		skb_queue_tail(&audit_queue, skb);
-	} else
+	} else {
 		audit_log_lost("rate limit exceeded");
+		kfree_skb(skb);
+	}
 }
 
 /**
-- 
2.43.0

