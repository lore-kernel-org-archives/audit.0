Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24CDA54
	for <audit@vger.kernel.org>; Tue, 31 Oct 2023 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="FJg05QhW"
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0460A10D
	for <audit@vger.kernel.org>; Mon, 30 Oct 2023 19:02:34 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-41cc75c55f0so50612111cf.1
        for <audit@vger.kernel.org>; Mon, 30 Oct 2023 19:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698717753; x=1699322553; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ztrq4YBof36EuC9p7t8unE3pcq3LkHbGfTdfd8TB1gA=;
        b=FJg05QhWJmLN2hv5xcl3rPo06bb+e60KOUMs0tOkqS3OeEGm6fErzZa+MXZO47Yt0s
         rHSj90P6aC0WD3OJrfd9q5Q1LCh0IN8+IaesRenqk0p7GO9W2JpCJ4hvdeQrdF40w7FD
         /ofzICawr3zDGsbpdYe1llKlPa+ic79g3IE1oR1tRpFKscL/Xt+1k6MnGNPBUXvqpuJ4
         smU7KpVqKeRAdcCdPlUn5wzLAk3rOhS6L505NmVWgevmCSReoKNelaEWI7arD1SsK9Pt
         TN2mWc1JFjRY8Qahu6+XjEh5EVehTOU0IjvgMl0tdyGDmyDR+ihldwsyH6GD4C1BfJVG
         VZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698717753; x=1699322553;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ztrq4YBof36EuC9p7t8unE3pcq3LkHbGfTdfd8TB1gA=;
        b=Qh1u4y5Z3vofs1+eik4m0+Mx8iu0/rMw5soy8g6N/MOrdGGo4FBkOyb3GundPIGfqA
         91By66OY48R0XrVSQFj5ndtEZPjjWylic9qXEYwWPhWS/HaFD0m7Gfu9eF0Qqd7dP0tY
         sO6wWtIbmsfi9LNZ/cpzZvgBShmsyhKjIfaa2ysuzhoJLfqJyyzWGgO1HwLdBs51fLGn
         xK3g6epCxp1apjAlhF35kfUHFJv9P8u/3UuoydnK8L+auF6NQCBkapolPLbaaX5s2ish
         EueN2+ZOtXNZkmpjxUXGvv4PUN9Tts47YuVfWf4XNOP48EQLKH6DIonwXzZ84ZcZpk/r
         7Y/w==
X-Gm-Message-State: AOJu0YzctLwvLYGenExR3bDwobXz5XOZZiSs6LVS1820Lg/Evz3WPVdW
	3NXRVPqcv3NXmg0WZvDTVGBrXEF3UX1HyN3ySw==
X-Google-Smtp-Source: AGHT+IHWJyeajQ3qP9clxCroCLoIaUQFJvCzNz8pqmjiPFRMVaoHu8bvxk4qc7TmLrJ7IvKNjedX7A==
X-Received: by 2002:a05:622a:174a:b0:41e:535d:3de2 with SMTP id l10-20020a05622a174a00b0041e535d3de2mr2351869qtk.28.1698717752723;
        Mon, 30 Oct 2023 19:02:32 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id 21-20020ac85755000000b0041977932fc6sm119576qtx.18.2023.10.30.19.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 19:02:32 -0700 (PDT)
Date: Mon, 30 Oct 2023 22:02:31 -0400
Message-ID: <1996b683505b00b7d4456eb37f42a24a.paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20231030
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Hi Linus,

Only two audit patches for v6.7, both fairly small with a combined 11
lines of changes.  The first patch is a simple __counted_by annontation,
and the second fixes a a problem where audit could deadlock on
task_lock() when an exe filter is configured.  More information is
available in the commit description and the patch is tagged for stable.

Please merge for v6.7-rc1, thanks.
-Paul

--
The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20231030

for you to fetch changes up to 47846d51348dd62e5231a83be040981b17c955fa:

  audit: don't take task_lock() in audit_exe_compare() code path
    (2023-10-25 22:29:47 -0400)

----------------------------------------------------------------
audit/stable-6.7 PR 20231030

----------------------------------------------------------------
Kees Cook (1):
      audit: Annotate struct audit_chunk with __counted_by

Paul Moore (1):
      audit: don't take task_lock() in audit_exe_compare() code path

 kernel/audit_tree.c  | 2 +-
 kernel/audit_watch.c | 9 ++++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

--
paul-moore.com
