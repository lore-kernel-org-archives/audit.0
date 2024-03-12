Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D4113B2BF
	for <audit@vger.kernel.org>; Tue, 12 Mar 2024 21:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277659; cv=none; b=Ay+vXPw2BVDwMyOqNeJowngVNXA6XGSbkGu5meC2GkUPzL8Iau5N9c/OUD/qR/v1kfgmXfCLFnm694Fn+Q3CmBX5dMj+4U7hGPZ7W8Ytmj4NBfkPFvZPNsU3yJENUg0+ZzpO6fQfS7ySNrHNw6HvcUfTCDaOA3+hIdiGhV95HmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277659; c=relaxed/simple;
	bh=D6bjhG/P9dFrD1W0lCskKTkomdq1ZxzgKWiMitBwAdM=;
	h=Date:Message-ID:From:To:Cc:Subject; b=mpNihiKA3Y/zHrZNDnCGniJc4YUCBRb/HcvjbspDuSQ5rldqebPhaPRqhcZXbu59Q76TXa5DlLP7OGqN/GdlS8+qGjQbTH3m5QwCrzFA/k9pFV7LCM/+ZQQWyN969Hx9Mdf2BTLilseZtYYfO73Z9JJxLJAVXo0l55IiVwK30FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IlapvdIP; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IlapvdIP"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-7dbd6e2dcd1so1481616241.0
        for <audit@vger.kernel.org>; Tue, 12 Mar 2024 14:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710277656; x=1710882456; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jo8EpKLrI3zTu7k0f67xQqGTdMNEkmN1IsZcTCHKRUg=;
        b=IlapvdIPZZEsZtMJq/kh0ohwnZmBeKjC0dXjgzXpCEVrLIckZ6rcF5opcFdkrYDr0A
         mvMRMSpBnzPL1g1Wv0CmxQnCSmaDpt4G6W5B6bTRe6IQ3A1T18/XxkrN34mYKfOnkuq2
         1PUAezAHZPLBoYlp3/vNcfGXQN64sZoueD00ZRwNeZZJW7vlSohr0ekIfiZwE9c3OK1f
         3sYW6bGQTFneRXHkePHxP4ulBveBUyQAev1j4rHT0s/XiWQ/V+qyMnIDkLjDNiMjn88G
         l/PXrAwGJuit4dxZ9vQ1uKfxVR9LSf9a5NJzhKrl4pingNyx3eY9ArbBOx6vp/ssX67c
         V46w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710277656; x=1710882456;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jo8EpKLrI3zTu7k0f67xQqGTdMNEkmN1IsZcTCHKRUg=;
        b=GZAG5jhAocKkyqsSyXf9UkhhEip0zBXuF9MYaEhQK6fXRW4j6EORV624ZqAgzDci33
         62QO3RDuSl3gV6N4t0/d8Be1bhhnHovi9nY6fKAORNwzRABhBxtyaoRNO1nye5tRsGbo
         Yn9f9KIzesRfsbGa8VH/4Q0ulzMLbgJfmbwuAl5G2uBVzlOHHrIKpHCMEagbNxP+24rN
         FKxEyUN1S70B6oqXcL5ykpJAQAwzoRDQQbJGLgTz5OdnavhRDJ1TuZ/qe+EU+WwO1N54
         m8/ifA4bplmcdzx6vbzs+e8EOVxhCjHhUxOLvquBHAdwRiMf7tYUP4khvamVAeLBobUE
         ZM+g==
X-Gm-Message-State: AOJu0YxRphVz7rUiF/mvLcI3ByG3EQcCSFyM7z+5MSL4uV+/kos86TUC
	kAghI+hwJlYHNBc28YfzeWqdcvs2vt/L65eGbo63h+aGsQzwd7HwFRxVu/0P4WCMZPlPU3T5Hg4
	=
X-Google-Smtp-Source: AGHT+IGdwmqIFShIOp0WZsGX63Jarjz6bvBb99g3Q5DGkyLnVCwRspzO50NKm6KImM+pL2+60Lj/UA==
X-Received: by 2002:a67:ea45:0:b0:472:7619:1a63 with SMTP id r5-20020a67ea45000000b0047276191a63mr2174921vso.35.1710277654557;
        Tue, 12 Mar 2024 14:07:34 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id lw16-20020a05621457d000b00691122f25cesm91861qvb.4.2024.03.12.14.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 14:07:33 -0700 (PDT)
Date: Tue, 12 Mar 2024 17:07:33 -0400
Message-ID: <a51f65333f170f8079c72d98c16137d9@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20240312
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Hi Linus,

Two small audit patches for the Linux v6.9 merge window:

- Use the KMEM_CACHE() macro instead of kmem_cache_create()

The guidance appears to be to use the KMEM_CACHE() macro when possible
and there is no reason why we can't use the macro, so let's use it.

- Remove an unnecessary assignment in audit_dupe_lsm_field()

A return value variable was assigned a value in its declaration, but
the declaration value is overwritten before the return value variable
is ever referenced; drop the assignment at declaration time.

Please merge when you have the chance,
-Paul

--
The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20240312

for you to fetch changes up to aa13b709084a0287ef250a9fbde5993e4dfc3078:

  audit: use KMEM_CACHE() instead of kmem_cache_create()
    (2024-01-25 10:12:22 -0500)

----------------------------------------------------------------
audit/stable-6.9 PR 20240312

----------------------------------------------------------------
Kunwu Chan (1):
      audit: use KMEM_CACHE() instead of kmem_cache_create()

Li zeming (1):
      audit: remove unnecessary assignment in audit_dupe_lsm_field()

 kernel/audit.c       | 4 +---
 kernel/auditfilter.c | 2 +-
 2 files changed, 2 insertions(+), 4 deletions(-)

--
paul-moore.com
