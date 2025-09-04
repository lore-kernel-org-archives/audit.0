Received: from mail-ua1-f74.google.com (mail-ua1-f74.google.com [209.85.222.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0437529B778
	for <audit@vger.kernel.org>; Thu,  4 Sep 2025 07:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756970744; cv=none; b=YQnGCN8i9XIhP+HHo6FtyyjS/+UcITwk0ZKsq6a938gLVjGUefcNZwyzqYDDctJhzfx8bLpq0P7Uiq4a+bxVfruAkDOdR2zVBlfSY++Ka5/zeScXSPgf/8rB+bby0V99vQ2CY+I+WqVRUJDZVNltpMrQYgR0c9sRl3wUuP3WF+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756970744; c=relaxed/simple;
	bh=NoAEI1qxVcsQ6DYeN4T2CiFqL+okoOWU6OTz1fbr+8g=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZOj3VYNWzCpPfm4zUSiZ7Mif+6vetBRTjttcosoSl9LkjUXCPY5jqNeyJiGXh5pvLPgUEJaeN9Ie3xXnl13NJ9eJ/5+K9Zh95XMcJa8t17Q+aeJ0KJJ1+aGkIXN0uNoYJL4yKBXdUotjMhPw+c0q0nQgWAof24kNOalso8kMYA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GkYGvWfS; arc=none smtp.client-ip=209.85.222.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkYGvWfS"
Received: by mail-ua1-f74.google.com with SMTP id a1e0cc1a2514c-892460241e3so623879241.1
        for <audit@vger.kernel.org>; Thu, 04 Sep 2025 00:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756970741; x=1757575541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MPQVkAFMgmOhR8+kYXpb7BN7WiH06c2CJj9w5v/CuXw=;
        b=GkYGvWfSOB6sbOSgCigx4CvcBdcHSPIiRp+AW8seHt9g6l+YfJtclAxcmVHKIkrnuV
         Z9AWf4zJgMe68vuX+7VsinhZhDidUghN4zoOra89kFYlTnWPyk3yfhL96GbEb+KK2dGG
         NzDl103qlOU3CtRO2WCV28hMkOdLuaR9naJH6puti3tpvoQDuRNJz9DbwKAVh5fdKSuk
         TOzHKgUbWxZnIHb+SQz6xEhHWZ9JFhpUi4eY4mA1SnnnDmK2E5IP2FeIIYJlKggldIXT
         nTXnV817vr6WtpMPPecGtt4QgGE7K+c4ddMMDAzR6NsRrK1TJLmGpvnkemTH32i1Zwnj
         YNLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756970741; x=1757575541;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MPQVkAFMgmOhR8+kYXpb7BN7WiH06c2CJj9w5v/CuXw=;
        b=SGngx/Tl6+zUX09BaH/lfWm06Of+zttVp0oq8TiSkSLpco2DBC1QZoy+IlQIHvWnhV
         PPiuJTkB8kV45uOxEKY0CT+PqxOuLFZVofPqyocrlMCDoYvc44OeBFv49m62qqx5TqSQ
         JqBOJuJyzdmfd8wtDrFuzubSANkhx4YaGE3Fc4wJegB1cJcZrADOe6x6lNQ+xZkfKD1W
         +tGJGZ80uMzmwvExI3mDLkvWm1B9Y7EDmg+f+v/A4j3F3PIzXEg2Mw+URmiVwsLTyOoV
         tqpy201YMnPGCaYv4Fh1+G4UKLv9d5ru/Ot0oUXXeVbZ/eJvpdz8hU51Z4iREVp8N2jL
         ypKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV30+loJ8CXs/J1dzMiGXaZWa5sSmaOhExLCwT8UIQ+h2bUxJlUizHTm8CrIJO+qlJDPnKRpg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzek6yi17akzx8ltlG4DiASgm+mtLZTsOBC7xh5r9QDYzwO0Vpq
	c98mIDGca8cp7Q82IJ5UUJ/UtD0S3QSodCpOFc1hPjwDwKJkubbmQ+BZdW5T74jcAuu5fYQ5Yxt
	J0m/NzQEV2dp7CA==
X-Google-Smtp-Source: AGHT+IHbPWd89svBphXZ7pOsltABNLESlaMmG9uM8eaeOdLkw5PpSHqif8D5xIT1A7cB13jOEQimM/Mr8nVHGw==
X-Received: from vsbbw7.prod.google.com ([2002:a05:6102:5547:b0:523:510:faa5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6102:4691:b0:524:2917:61aa with SMTP id ada2fe7eead31-52b1c149c51mr7026803137.32.1756970740886;
 Thu, 04 Sep 2025 00:25:40 -0700 (PDT)
Date: Thu,  4 Sep 2025 07:25:37 +0000
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.338.gd7d06c2dae-goog
Message-ID: <20250904072537.2278210-1-edumazet@google.com>
Subject: [PATCH] audit: init ab->skb_list earlier in audit_buffer_alloc()
From: Eric Dumazet <edumazet@google.com>
To: Casey Schaufler <casey@schaufler-ca.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, 
	Eric Dumazet <eric.dumazet@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com, 
	Eric Paris <eparis@redhat.com>, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot found a bug in audit_buffer_alloc() if nlmsg_new() returns NULL.

We need to initialize ab->skb_list before calling audit_buffer_free()
which will use both the skb_list spinlock and list pointers.

Fixes: eb59d494eebd ("audit: add record for multiple task security contexts")
Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/68b93e3c.a00a0220.eb3d.0000.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org
---
 kernel/audit.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index bd7474fd8d2c..707483879648 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1831,11 +1831,12 @@ static struct audit_buffer *audit_buffer_alloc(struct audit_context *ctx,
 	if (!ab)
 		return NULL;
 
+	skb_queue_head_init(&ab->skb_list);
+
 	ab->skb = nlmsg_new(AUDIT_BUFSIZ, gfp_mask);
 	if (!ab->skb)
 		goto err;
 
-	skb_queue_head_init(&ab->skb_list);
 	skb_queue_tail(&ab->skb_list, ab->skb);
 
 	if (!nlmsg_put(ab->skb, 0, 0, type, 0, 0))
-- 
2.51.0.338.gd7d06c2dae-goog

