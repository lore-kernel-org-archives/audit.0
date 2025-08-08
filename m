Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C412882A2
	for <audit@vger.kernel.org>; Fri,  8 Aug 2025 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682044; cv=none; b=F06pAHRdON4jmznAksTKJ5bRKtMg0bkVAn0h05RuxqSgcJSlj+iBIqhhykrhOcoGc2s4PDRKZ+Px+mNEh6Iigp4GPr96QeSlLLI8F+8ZquMuUHjqNZhkkySv/4wCWTOiJBQPMqHIzJpgyg/tlqjtyHSFJU97fsU4BIGK0zgh6W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682044; c=relaxed/simple;
	bh=fbC1sfGTRwM9KVR6ISJbEGyq/BzRDCIS9DtaXdb/r/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l8tjuLc5L7/9FaUo1M4XxzOyqea7Xft/gXJLsiBC9GDAyTsa9aN28+YVKmKDpTQpVqvZOk1lqcoh2E6U3A/gNNyCL/EOUNOFyN0wFwVOrFGhj7+i8khrqz6iOrEpXEeTOs0+qU2Y6AVldo2pa238Yvth8os0brvENOC6fQI3i6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=B8InPqWO; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="B8InPqWO"
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3e41b930105so13681485ab.1
        for <audit@vger.kernel.org>; Fri, 08 Aug 2025 12:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754682041; x=1755286841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMTURUrnQNZrOBYjWC1Rn+SnR4z6iblLoVxNeceVQhw=;
        b=B8InPqWOcC6SuFMU3Zyp0g+xxcwJoCteiIftxSlM5dorsvmt423jpqIOIMUYFJ7OMr
         X3BXZdMfkkf+ndfAMR8cBQiXiItcl1U2MtEtKaZ9KD2z31slE7/QFKEMROgNCcEF+/fB
         qF1jo6j+dQnF/pkdE2DZQhiaYQfXZpCqW+nkp4SEi6biEjUHZXA4rIRVGpeacwQjDYly
         1QE5AHbkbMwnR/w5kpCrv6eYNDD2SRuF/ozCRsVM5Ey+nO4u6WmN5O9vgHQbE3vqPaZP
         VwIVoOU6yu/+iAnCb4acGyPZNeh70nyvi4RcCZ8ZHcpW0VB9Y4m/yQV672QibgwcZHsx
         XMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682041; x=1755286841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMTURUrnQNZrOBYjWC1Rn+SnR4z6iblLoVxNeceVQhw=;
        b=ktcPM2yNurKMStVS9T4M1gq4sp+RBP1EUac5YZ80jCrPfrHHgLttUxYgNu3WTSzRvU
         Yqw0J8g9oKJVYzirV0txT7WoHgiY775m7jOYnjcxlsew5zJfTiz1mHTPl0DfZHHg/qHC
         Ry5APAlDQ8SZ72MzGyL/kZpbqbCxTMXWbR8AOt/JeUBgHWtLT6ZsYZqcqr4LyTkwuhgg
         spWAFUju+ToEQp7TCSfzKh3+Apxf35g6GZwOJCfTW0qhQfuju/hEHYQv8cqWKI1SnB2q
         jZuvmHaXtN2FmRCGjHpaqjmhxml8FKFdj72gkrKwl1RuLRHrPrrUGsQDDo1MYKRGL3xp
         9iKA==
X-Gm-Message-State: AOJu0Yx9Ug3kznaxnvHM5zBBGjLCUfz28gvnUW4aQh0qCj8arz9Q8sgU
	22pH2g9/dVr1iNQLWi0hkdWNhQ27gHC54fdPN3rb81CkqR9hHW+YbaUdtTy4Du05DII=
X-Gm-Gg: ASbGncsye7K9C41eT20BILvtQqJ3sAvhytxxpcIBFBZb5KMY1sZ31/U65wibqbOGx/h
	ofDarjdrFTDyLAY/1HQVSUcvOsnjmAVpi1aCSfmmtIvS77jRkiUQOVu3FXE2a85njzoKJZs69Oo
	jf8Ckes1JAVYC+YJ9H6whOqxrF9CnMbOovGnO67EZfXHX4iPsCOlgSrs+4YJ7wTrxCBvppysu1I
	xGqrWBCC+niRJfDhXTBlUzOyJDg6sZL1TPiVGY/iXhZix6a8RtwId0XUqXV7a80XKWJRDEBxzPP
	5CMMRXMN5+i6joVipr/Ebl5sDixN8nk0GkDJf/60XENZM4TXCdakS7eI65olhaIeWpwHTLLx1o7
	dXdvT
X-Google-Smtp-Source: AGHT+IFlTg6qyesY84rUV5KNJ8QLoCgYNF59EcWDBZiEsfgkJ/Ld63VaD6K6KCZdZ5B2HMUbA03MLA==
X-Received: by 2002:a05:6e02:1a07:b0:3e5:31fe:a47d with SMTP id e9e14a558f8ab-3e5339b2925mr68396935ab.2.1754682041073;
        Fri, 08 Aug 2025 12:40:41 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:8255:4e6::7d:6f])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e533cdd3e6sm10482345ab.55.2025.08.08.12.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:40:40 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
To: Paul Moore <paul@paul-moore.com>,
	Eric Paris <eparis@redhat.com>
Cc: audit@vger.kernel.org,
	kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org,
	Frederick Lawler <fred@cloudflare.com>
Subject: [RFC PATCH] audit: make ADUITSYSCALL optional again
Date: Fri,  8 Aug 2025 14:40:34 -0500
Message-ID: <20250808194034.3559323-2-fred@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250808194034.3559323-1-fred@cloudflare.com>
References: <20250808194034.3559323-1-fred@cloudflare.com>
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

