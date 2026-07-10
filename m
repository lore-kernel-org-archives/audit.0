Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04649383316
	for <audit@vger.kernel.org>; Fri, 10 Jul 2026 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783710833; cv=none; b=aBODq/Or/NWiNneEV+F2MKYAR2TPxrWqQDXeVyQBF85+Bgthwu230qwWRpeH6JLV18v/mb804TfOidd1bW0NiobUto0tbzeNT5fa6thsbYvXpVpIMhBhQ1enieEnnldTCs+svatlCC4OVNmFWg6j+44oofV0p+mJX7rrBSjdsLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783710833; c=relaxed/simple;
	bh=ypn4VsdDrtJH0lkXwT3qQ9PMbwHn5YUow9UboleZxE0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=sNXtMFs11r2oz0WqZBky9Lb3cCS3xKPPdllW2KLmHF4Nvo3iB6rqGiXv2VjyGabvxSzG9FtsComkP51sdQbHPXJcndNwgVEjdZimarV94+dEvS1hKejW2dz6sgnZhvERfaGSH/pR4NsyDt1l/V0Ij6cU+cPCQoiKIXV5TnZTh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eM8hp0Dl; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eM8hp0Dl"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8eefd0c5f59so9684906d6.3
        for <audit@vger.kernel.org>; Fri, 10 Jul 2026 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783710831; x=1784315631; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TG2ypb35e4TY0ysa6wPuGtoHdY27NOJGbhHYW5XAyqE=;
        b=eM8hp0Dl5DBK5jGygRo/oXw53e+vw4kQI5bL+rGBBHuH+ZP0JNlZaM+qBXkFui31/O
         qZqDlJrj6HOYtO9Mw4YU0swzALRAOvUYjlAAPv5TFiBDNhisM/EFPo/Uz5a+h2y3nZaO
         Rd9fd7WTpSqj4it/+4PB0mz7lABa+Y3bXoHDXo7xHus2aU0PuYpeasA2hAd5LoPZ7HIh
         VKHk4hHH8b6JKcZW03Bshb9v7VRIG/gs6imVWlTfWOTRuHqxssiT5NTd3/ARl5XVqdz0
         EfSUQKWrY3jUtXXBTuGwOYthVYxRhtrvDs1UdvepSV6zZOuPEZwBJr0XHwYCWXBAM3RC
         +L0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783710831; x=1784315631;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TG2ypb35e4TY0ysa6wPuGtoHdY27NOJGbhHYW5XAyqE=;
        b=Eo75g1XThRuB1JNVwewLml74HyqNt6LctDYPFGLOauR6cEcEHDbUu+PphxIxfB3qYw
         gmfrhEDzxwlqslF/5dLDyedWvK78fmgiaPCYjMRdl34uxnLThwa/oQ9nJ9IZo2JNxlPT
         //N60smYLtP86uFsKauK5W3VCa9lh7Ywa6k4/AvqSO9001+Stjc98UY6NJg91uVGpp59
         1n6922Kom+g0Jvty1+S8hCUH1a5BCzoelfL9773A380bRMj+UGd+MKsf9fNIdk5mra2Z
         S78LsT9CZJ+tf3dLjozbeKqrlHDLWdEC8wDDOcdbM1FcHoc+gMhnFSfkUrgpPH38ItSz
         Seyw==
X-Gm-Message-State: AOJu0Yy7u1XcZSBuUqfSjCHwgYVKUQx+atnuS5Xb/ou0QoFQ1NOiakfU
	cDcHWNQyg2Qs12muhrMaKOVaTrKOhiEo/7S19+yh9x6ALaJYENLTQ9h/XurACsFxOkCQIfHSVyt
	uYEsprQ==
X-Gm-Gg: AfdE7cmBWOU2b05O50yV47cuwFrLyY0eCNazpkuZJfOH7wokMmDvAepDu497GGV97ZT
	qlwgNV4rzRQpyVZlANMq5J5zmzRAbsD37j7InbvRNQe8DcTBnYcAsHnGQGI+x9PZuzmfLiwx2HZ
	VwpSJmVKuxyINNyGrBnqO7f8oRlpX4F2EzTtGD1dcBglsOxmdQ45869zJrcN/N8Zt9tHtSZ7Vmn
	TGyNFF0eNYY3dDwKUqo6nRZB0bU+2Xil/E7jUNcBcDLb+lRtNcY2IoWSzZv1PjJPawFNLzEuxm5
	kFSwNpbUoubcbGiDAm/NjdWSwJs9Bahl0QJjLiTSAKVDMLBIGyuTBUD9Xb4LLOUGmKK5acqdkMy
	QV0qzLsFPNM+3rPWtjCYZvH8RfYNQO+u0KmgCz1a/CzGaqXXPxLDjc1kHQt5q3ueQFSx4LpDJz+
	nNfEPc/twmhfzZS7z7pp5cUU5D6lRC3CVtQVqbgnrjl/DAahbRjQHr+4ffjA==
X-Received: by 2002:a05:6214:d6d:b0:8f1:d316:42cd with SMTP id 6a1803df08f44-9040027dd5fmr5380086d6.25.1783710830879;
        Fri, 10 Jul 2026 12:13:50 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87c9500sm48012856d6.46.2026.07.10.12.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:13:49 -0700 (PDT)
Date: Fri, 10 Jul 2026 15:13:49 -0400
Message-ID: <a307fda8417d3a1e3f6985535d4a62ae@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20260710
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

Two relatively small audit patches to fix potential data races with the
main audit backlog queue as well as possible integer overflows when
logging data as hex strings.

Paul

--
The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20260710

for you to fetch changes up to 65dfde57d1e29ce2b76fc23dd565eccd5c0bc0f0:

  audit: fix potential integer overflow in audit_log_n_hex()
    (2026-07-08 14:22:14 -0400)

----------------------------------------------------------------
audit/stable-7.2 PR 20260710
----------------------------------------------------------------

Chi Wang (1):
      audit: Fix data races of skb_queue_len() readers on audit_queue

Ricardo Robaina (1):
      audit: fix potential integer overflow in audit_log_n_hex()

 kernel/audit.c |   21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--
paul-moore.com
