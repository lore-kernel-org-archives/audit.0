Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB76724A047
	for <audit@vger.kernel.org>; Fri,  7 Aug 2026 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064509; cv=none; b=AYiecqmNd64OwrfUxgb8XY8oTErtjYTEwSrEPng7PEGY1sTAyz11ztE8LwgnXhWGhwuMSTrGGxcJeUGCUkhSCJREPmGx+Uh9Bgvlvj37DPx/J7RyRL5OQrJUaLXVjwuPEocPogNE6vLZ1iiAtimwp6wyjJcH8ovwObFY77yz14g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064509; c=relaxed/simple;
	bh=ijoFRb8I4+XfGKhziEfySAslvbu5Jp7Eu4JILnrr21g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cwDO5KWzFyIQQMe168gZDWCTX5WLcl63WVfmzv9qpd9uDuQe1ITJsFblnGDWzYf9hqpCnRL0PjA07I79bb/zi9WwzpdBsUOtelryW53db92NDbMVI/5LgKjzWiZTsgMoTFm5WE2lr3wYq77/Nl+R9Tyni5jUkVzYhtn3HxWVueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xa6hllnu; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xa6hllnu"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cacb8416a1so29913835ad.1
        for <audit@vger.kernel.org>; Thu, 06 Aug 2026 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786064507; x=1786669307; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MLGlXfDDWhpZIsWPnXZToOCK71F6INAB2KuWQUQm6mQ=;
        b=Xa6hllnuADsAHxIhn+8S84ftMtguMQmWt7NNTSqaNH4uBRjYCs6vBSSLnTQV5id6rE
         YdDXNqlvzpHYDlr2oQPXt/SxEjVVLv9oGFAJt9qb7lQavYcgmdCoGjeoiAJXlnVm420P
         IYEy8pAm8hqiCgurLVC6O2j4gqg0sdx6fJ+7F6jplqHn3ULK09+yd9ZHoFiJKqbL9QIg
         tQDtaoU1no9RIUNZCYeTvMQpQ0iSzbkJI34ZM0qf7wa5q7gZrDGiak7WczO4U5lfSKAn
         C87a+d6iOq4fptcEKfDoTQ5TpgH8+UZr8ez13XL2z2VqMRpFSLJ3YBN3XsMyHSOXMyp2
         myMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786064507; x=1786669307;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=MLGlXfDDWhpZIsWPnXZToOCK71F6INAB2KuWQUQm6mQ=;
        b=SeX4rg3D8qjXoJ4vlV46pWLpSU6AzA+XcfO34MzyRa9+I0+hAryLcASVGDi3SsmQwM
         tD1P1HQV/fGBAy+agYrOrhUuKpwPsgIAWyFyRUMHIDfXGB5R6dBGqYqb/oZVIHk/bJWA
         jUL/ythPt8Nfj1IHY7m5CpjVb/rnlYj8CBWPEcbNVxxooXn0u2nhv6lHfR97FPlTTp58
         +oelXUPj6nlVlIa/CLPflVqPqE8pwHCrUe29R+FJP+GZgeGq8xllFiaI+XPyt2NJAdqS
         T8C9YAY3Hc3C6dggCCqBPb9yNCRBX0OepPqCDcoUUHmo8VY8j4hJhThRjEOURvyfu+Hh
         ZjNg==
X-Forwarded-Encrypted: i=1; AHgh+RrsHcSm1b6EU/myQ7FY4pxgbzsKh0ursvKx9Pkw63johAl0aPRo2nI5Z7/6csW/SWljiXKxpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN5xsVufu5E9GAKNwhmFNnkW3wimpC/sudjHzJpTiK9r/9kh1x
	c1b+ggtDRzRA9xk/N18DlcsleHqc2zemCKAMErdCfNa69dKmZ5Ce72sy
X-Gm-Gg: AR+sD103qC2LadppBxDLdFC5a16kSeyrKG9qrJBJuC9fx6BZ2RLflaalxMBLJBlefWJ
	PVG0mzHaSZSBIjDtZxaYgD8IJAQvS3orwsK8ChLHwHK8mQ+6Eg9wqqBAZE7FdBFdchs/6iRSIcK
	52W94zzxZibyx04wEbSesG49at4RHvjixFdGFxJNo2bgBTf/E53zzeQREvEa1cJRh6jbmPYM0U8
	CLFG7emyhtp2T0FN53ahk33R04w7C9seL9FvAAMqHU8YNMeK580D6qDPcBOBgwCjLN9blKhsNPD
	FcAT5EoDvyn6QV79tDbeNU7gy5CvspSrkMCt3k35MhltaPNnVu3NjjPsPzcfwejvPTU5zUTNNxW
	UQvJ7jDnxOyfdVvpFHVEVWV/MeDeE9GNasabs9VnOOrZiuJmdFDcCPFcMqLVr4VEyj+asogp1Lw
	VjKS2it73Z93j6i4q0lTpQwCXTrkCwO1XXcCmTXbjCv9gxgn2hrk2yWY6eq6SgVWbV6WN9mOwhP
	NV3XUqbqEMgOu4c1oLvESESWIj17v6dSH0=
X-Received: by 2002:a17:902:e541:b0:2c9:f44e:9942 with SMTP id d9443c01a7336-2d0ca7fa95dmr202648585ad.13.1786064506751;
        Thu, 06 Aug 2026 18:01:46 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14d7684f8sm1527725ad.33.2026.08.06.18.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 18:01:46 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Subject: [PATCH 0/3] audit: Measure and reduce syscall filtering overhead
Date: Thu, 06 Aug 2026 18:01:18 -0700
Message-Id: <20260806-audit-v1-0-ddd0d94ff0b6@gmail.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF4udWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwMz3cTSlMwSXUuzRMNUc8MUY4skQyWg2oKi1LTMCrA50bG1tQCcBI0
 lVwAAAA==
To: Shuah Khan <shuah@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Eric Paris <eparis@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Amy Griffis <amy.griffis@hp.com>
Cc: Stanislav Kinsburskii <skinsburskii@gmail.com>, 
 Frank Hofmann <hofmann@deshaw.com>, Noah Orlando <orlandon@deshaw.com>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 audit@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786064505; l=3293;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=ijoFRb8I4+XfGKhziEfySAslvbu5Jp7Eu4JILnrr21g=;
 b=/me/Wzzt3Q0JL3nWbvqc3DH08vOV+4pgXG8UcSC6ui6xM8FXaEkyc9K7WiicOYR9uN+oyVgM7
 p18cS5xN0f9Bi72Mcz7ssoQkRFDroSmck6dr9zx3x+VZb7isJcuO5FI
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=

This series adds a repeatable microbenchmark for audit's fixed syscall
overhead and uses it to address two cases where audit continues doing work
which cannot produce a record.

Patch 1 adds audit_bench, a manually run getpid(2) microbenchmark under
tools/testing/selftests/audit.  It leaves policy management to the caller
so the same workload can measure different rule configurations without
silently changing the system policy.

Patch 2 fixes audit_n_rules and audit_signals accounting when rules are
removed automatically with a watch or tree, or after an LSM rule update
fails.  These paths could leave the counters nonzero after the last
applicable rule had disappeared, causing every subsequent syscall to
allocate a non-dummy audit context.  It also centralizes rule accounting
so all rule removal paths share the same bookkeeping.

The median getpid latency in the same unpinned VM was:

                                  no rules   stale state   fixed
  automatically removed watch       38 ns       55 ns      38 ns
  automatically removed tree        38 ns       59 ns      38 ns

Patch 3 builds on those lifecycle helpers.  It maintains an aggregate mask
of the syscall numbers present in exit rules and checks that mask before
walking the exit filter list.  The mask is architecture-independent and
therefore conservative: overlapping syscall numbers may cause an
unnecessary scan, but cannot suppress a match.

For an unrelated getpid workload, the median latency scaled as follows:

  exit rules                         1       32      128      256
  before                            55 ns    71 ns   428 ns   791 ns
  after                             55 ns    55 ns    55 ns    55 ns

The aggregate mask is updated through the centralized accounting helpers.
Insertion sets the relevant bits before publishing the rule with
list_add_rcu(); removal unlinks the rule before clearing them.  This keeps
the lockless rejection test conservative during concurrent rule changes.

The series does not change the audit userspace ABI or rule matching
semantics.  The benchmark and complete reproduction procedures are
documented in the individual patches.

---
Stanislav Kinsburskii (3):
      selftests/audit: Add syscall overhead benchmark
      audit: Fix filter rule accounting after automatic removal
      audit: Skip exit filtering for syscalls without rules

 MAINTAINERS                                 |   1 +
 kernel/audit.h                              |   7 +
 kernel/audit_tree.c                         |   1 +
 kernel/audit_watch.c                        |   2 +
 kernel/auditfilter.c                        | 140 +++++++++++------
 kernel/auditsc.c                            |  13 ++
 tools/testing/selftests/Makefile            |   1 +
 tools/testing/selftests/audit/.gitignore    |   2 +
 tools/testing/selftests/audit/Makefile      |   9 ++
 tools/testing/selftests/audit/README        |  30 ++++
 tools/testing/selftests/audit/audit_bench.c | 227 ++++++++++++++++++++++++++++
 11 files changed, 389 insertions(+), 44 deletions(-)
---
base-commit: ea2bff00da89d7767d677bb68470130ba96f4928
change-id: 20260806-audit-96a1e71d38b1

Best regards,
-- 
Stanislav Kinsburskii <skinsburskii@gmail.com>

