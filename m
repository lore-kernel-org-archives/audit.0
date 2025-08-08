Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CC239E80
	for <audit@vger.kernel.org>; Fri,  8 Aug 2025 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682041; cv=none; b=YNxq1GmOvbUas2ma33bh54sH1FmwUdIpnCtqM91lz47m+8GYCJNcsUs7RbEXIXsCBMBoV7+zuNznW3rDX+cNA2j07TpM3Zq0YU4lgvNOSZdzc96eTSC/PsubzuNPff1zzSfMZZElKcmswZ4DQf7d0sOs+KlVNFYfmvfkZ4Np25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682041; c=relaxed/simple;
	bh=fbC1sfGTRwM9KVR6ISJbEGyq/BzRDCIS9DtaXdb/r/c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VeaqEXp0VTkbBJKqNQd+eU5KP7kXzzxecCP1iiFcthl+2PUIPpidlaPa8dA5KCFoI4XGcXJpe7IVfg2t2y3pct4zRQIJqrN1Qo4Ojx3IPDYK470+OF0XKghkqEy0q95robH7vubWDunTORu4r76BxZsi75Hsv9Qjibgwu5Juhbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Qv9VyF9q; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qv9VyF9q"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-881a20ebf60so105591939f.1
        for <audit@vger.kernel.org>; Fri, 08 Aug 2025 12:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754682037; x=1755286837; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dMTURUrnQNZrOBYjWC1Rn+SnR4z6iblLoVxNeceVQhw=;
        b=Qv9VyF9qPpd8lyhs9+zp8dCC+g1vvP4tCU6o4dVfoZAtOeATK8LMR9DflHuvF0ppym
         tOzdBv+QMyZKuaYEwMpWd+pFyPJgCHNfR/OZo6PGDF1Ut3JEdUdJcf2NuXZzdMsZNJ4J
         Gq9dvL5o/gnjZPmjxt6A7YeP/s3pRk5OQQromBo68D/9a5cpDE9UVtwDlQwKfNFk0L4P
         v5TTCZote1xBOR4TQrlUBnnhBQDXpI/8aJucSUm0hE4XbBBlcPSTp7WXUsWtpqGAvNci
         +dH4TQKo01Tt0vPlJ7ro3nK5mRWJOcE7NNguyl09lT3+7f9QaeT9jx/9SFEb6O60eYxZ
         kn1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682037; x=1755286837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dMTURUrnQNZrOBYjWC1Rn+SnR4z6iblLoVxNeceVQhw=;
        b=EvT733olRlx8JIO702bhK+id2J0tksTWacNt3rGq3j3SeAUo6wKT6KV9g1a4o05SeD
         Jy2Rl1hZnBB1WtNoo1hlwM5Le9o8pjOmF8fesbWTNnoPXUIzfFRIeQBw8NUiTkkLnrP9
         mX6ocgZ75jE0cfZFoTk70OxhcgqUmGldQ1byosJu3+4IStq07dCw5ct0bMSuZJmIfnMj
         pJY/o++VwhvOUqTcmQphqVySkdD81HYhsv9hRgUCL0QvwPC2A+XEtjQnRxrQYKBLwWTB
         u7m9cGmMUu9EvUxBRFfUSN4CwCz/4A6UWqoTOKZFgGVcnrfIi/HQTAaHH/a3693EZ1L7
         Wtow==
X-Gm-Message-State: AOJu0YySkey8mPByWvlJyszLzGeJOthGIf13P4xqaTml3bOXhAi5Ylww
	dWCDX5pGtFOvw+3cQPAYAhEM94fxUqVT9M+OuQr2oBSH6HIT/TVF+YwjgNwvpwQJG/HsLFRz0ZW
	FX6Cewhg=
X-Gm-Gg: ASbGncsYrQ+ladnWypo3Zu3qP0qedwTFuiOODNJJ8p18+QFz/ddUrBIGBypAs2jfCgk
	wLFk3xjDJ+MZV1Yf/uPjoTW4KX3hfcBZeLlacgH4g/4G04y8pNnKu3jhVqcdNTXkI8nmJ+3irF4
	w6lKU+PlQTveAxAvWh6hJ0e1b2XbuLiBjKJQd/LHZ92q6DyEKHmC/v1+o/ka5wp3qDXIE4UfaXs
	hKcxBVfkXdLKcNF9mm63nncnby2ygDuYwO/wzxJ/CtH4xwHp9xN9sfJbrW7uIPlKrJLbm6009LI
	ykFYwwXx5NkXQxImmZmh8KtEmfJhlQtTVjGq2Z9eiSFgwRUbBo9nUxlkgnZlFRgUEekJlDS5Jkm
	kxTqA
X-Google-Smtp-Source: AGHT+IH2UpzKS18Oe6Yaqd1vLBnaMu6N4Av80bztoHhlVzqOmN+TBK1mKIZRtGXMBrujqw7T5yeUKw==
X-Received: by 2002:a05:6e02:1886:b0:3e2:c5ff:382 with SMTP id e9e14a558f8ab-3e5339fb3e6mr58553175ab.5.1754682037532;
        Fri, 08 Aug 2025 12:40:37 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:8255:4e6::7d:6f])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e533cdd3e6sm10482345ab.55.2025.08.08.12.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:40:37 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH 1/1] audit: make ADUITSYSCALL optional again
Date: Fri,  8 Aug 2025 14:40:33 -0500
Message-ID: <20250808194034.3559323-1-fred@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the introduction of commit cb74ed278f80 ("audit: always enable
syscall auditing when supported and audit is enabled"), eBPF
technologies are being adopted to track syscalls for auditing purposes.
Those technologies add an additional overhead ontop of AUDITSYSCALL.
Additionally, AUDIT infrastructure has expanded to include INTEGRITY which
offers some advantages over eBPF technologies, such as early-init/boot
integrity logs with. Therefore, make ADUITSYSCALL optional
again, but keep it default y.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 init/Kconfig | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index af4c2f085455..2552918deb45 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -487,16 +487,21 @@ config AUDIT
 	help
 	  Enable auditing infrastructure that can be used with another
 	  kernel subsystem, such as SELinux (which requires this for
-	  logging of avc messages output).  System call auditing is included
-	  on architectures which support it.
+	  logging of avc messages output). Does not do system-call
+	  auditing without CONFIG_AUDITSYSCALL.
 
 config HAVE_ARCH_AUDITSYSCALL
 	bool
 
 config AUDITSYSCALL
-	def_bool y
+	bool "Enable system-call auditing support"
 	depends on AUDIT && HAVE_ARCH_AUDITSYSCALL
+	default y
 	select FSNOTIFY
+	help
+	  Enable low-overhead system-call auditing infrastructure that
+	  can be used indepdently or with another kernel subsystem,
+	  such as SELiux.
 
 source "kernel/irq/Kconfig"
 source "kernel/time/Kconfig"
-- 
2.43.0

