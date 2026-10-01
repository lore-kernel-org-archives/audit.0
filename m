Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A9936308F
	for <audit@vger.kernel.org>; Thu,  1 Oct 2026 01:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790818573; cv=none; b=Y6EBCIlO7fNSITCDfBRNkaiV+rpjRx4KUHc5MXoexdQ1XtkMkCMYwtn2wt2xm8FgSPWeaMf91GldjGv0cwzf2qA2wgGGMF+lucx1Kc+dc25Vv2SiwFhW1ganppQ7q+4O74eaVK2pEnxmRyn/uV8XS2bgty/yeSiHZg93vc5O2GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790818573; c=relaxed/simple;
	bh=iLdqu+Ue4IoF3oJ7laKVZUnu6AmDbLf/d6lZ2bT8QRc=;
	h=Date:Message-ID:From:To:Cc:Subject; b=XBuo44IG/jmjKwzmKL1KaR2r0dZ/tm++Xje0U/1aR4l73A6ciEsao5hWDxs2Tj5l0xTnNIUHpBfsLmbdg8ylMg4YKQ1czORhI4rbQu58oSTr8TfuafENsA4a3S5Lq+XWgsPJxlDRnAh3mZt2CzhS6f/f8Pi+broR/YvfbNBO5yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eKAgWwx3; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eKAgWwx3"
Received: by mail-qk2-f39.google.com with SMTP id af79cd13be357-93c67dc38f4so231212285a.0
        for <audit@vger.kernel.org>; Wed, 30 Sep 2026 18:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1790818571; x=1791423371; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=B9UI6oGE1TK11TaDQg6HshpZ2UDiz++aB74YJjIRaBc=;
        b=eKAgWwx3Qi6hcF5thFFlJotvOsg+HGGN5NbvW9Bku6m1s42EK2Srhkcc1pAHlaODOq
         IARjLEsnSthRNjbm0AJmGbR2sENvVG+hR+PpdHCXcQRCMJDqNBhsgwdi0ur+gyaDHj+n
         giATvyZRog97naYQ330JOupRbIFbjO9+A0/+b5d6fl/leir/fAF+I3QRg8bha+bjim4M
         IoZp0TRWKhjGrCFsHllyxHHf24o7pP+YpZoONY5VdGeL/sgYUJsxniIeU2MOaBeffGef
         isCpwZ7bLG0Ru8pCZSLN8DXFtT588KvjfjkRGvAKXEbuC7ugs4VetQ0BJAMHVI23DKIq
         0RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790818571; x=1791423371;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=B9UI6oGE1TK11TaDQg6HshpZ2UDiz++aB74YJjIRaBc=;
        b=pEhYgIuTX8shllhKZUE+AhWzOCZAlLeVzsNEqvWOKjVXU+9sDC3vNDDgrSOZ4rp0qN
         jHNGDGmVRHBoxYDI5ZgWKyqAiQEsgzrGjy5yR3gTFatRwCIQBUoKK8OAjjb01aatGDmM
         WsTWoSTHBFU8hmDOo1GmdUpBbZeNhxWsuHGO6IeR2FlirHy8NzJn4iwP7pqmr6/uKGxv
         USZz/KnDlL0tLbCeMttgcTW514CxiH9bvu1vdf4bzRUBNqaeFYMI86Cdw5uj9xuO6juS
         PI/nplLcO/x92Z1asI3ErVdteIc4EUSH2J0KVSNTgOEyc5tPzrsRBHKduC/dYW7R7RBs
         yNjA==
X-Gm-Message-State: AFuF++mMZhwuhfzBEw+4sOybdPxUPoJ8+sZjohC7tGffmyajXGrTMSje
	fmWmRyjJQ4hY8SNDyqkwQdRR4kSUAaPtYAegxcQhb2sBZPDDBC+Opg9jqOhjp4Azjgcvds3kKcn
	abnXaYw==
X-Gm-Gg: AYBFou0mVSf83R565D3ci/C30LBN6/kvxFRCIgZy6NcA9W7tqG9DJp+FTe37y0iFISX
	HD9BFgMdNCVXIu1Cr0MsjgW5FK9LcQafaf22krvXTrCA1uYpwu3Ys1OAMXHn3Jn1TqaFlsy6m5o
	2f1/oxOUoRToGCCWb1wBvGjjUSXFUun3zth0kuxI9rizP9HPl1g2S8o1zNWL8FxOb9hSu2knxzp
	YdxLdlzIPiTaYcemSnI72nyAVTX4WsZcgtiMdAGh7bit9dlmMuDyxnAmXjYzuWCjPuN9lp8bVE7
	p149f3Mk89R6OIkvlss80beY3wrqzMCq2v8BmRJEErCABu+ceDdMdyCmKDIxBAetPeDXfnAWKgV
	a8K2MrMmAkLD6KV+5SpbXTBprB2v+biZyGtFd4RX8Ff9ov7CabaUCtWSqIwBnHFAdFTrdyhIW7m
	VmE9wAqDaICn8bf1lRFSLNJ9tRVTLBv0b7Oncuql96MNcT7a3cSdOH09//6I5lmtLf8s7Lqa5IR
	rXGKNChwUuJMQ4MfTpgKYPI+2vtIEYbNhR53+NHr6lmnwIhPAEiMhFPicIeBqbWKHuao/SWHlY=
X-Received: by 2002:a05:620a:2806:b0:939:fb9b:2b4b with SMTP id af79cd13be357-93cb563af87mr286730985a.5.1790818570844;
        Wed, 30 Sep 2026 18:36:10 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93cb64eb59esm101530885a.22.2026.09.30.18.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 18:36:10 -0700 (PDT)
Date: Wed, 30 Sep 2026 21:36:09 -0400
Message-ID: <ff3a2b285345da0c7aaece963e136aa9@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20260930
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

A single audit fix for Linux v7.3-rcX to fix a potential UAF error
in some audit filter configurations.

Paul

--
The following changes since commit cee9395acd8043be0644b25c34bfa86623f2b935:

  Linux 7.3-rc1 (2026-08-30 13:34:40 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20260930

for you to fetch changes up to aa650d87a498844060eecb1d336f4d46f4d1b0b3:

  audit: fix exe mark UAF in kill_rules() (2026-09-25 16:18:51 -0400)

----------------------------------------------------------------
audit/stable-7.3 PR 20260930
----------------------------------------------------------------

Jérémy Jean (1):
      audit: fix exe mark UAF in kill_rules()

 kernel/audit_tree.c |   36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

--
paul-moore.com
