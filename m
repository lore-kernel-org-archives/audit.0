Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747D6314A84
	for <audit@vger.kernel.org>; Wed,  4 Feb 2026 04:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178239; cv=none; b=iHJjNwjStkpu4uQMQl2AR6eSa9aZaVUE17fRiUWupP6D7OP6lPLcS4CM3shJQ3p9rIqBzu/tPe3izpOehpzQGKvDdZdEHyn8Ii/CDbgDHwb1ccBbIXY08TqNHdRKs7VcUw+df+VrgZkjv5OPgWYxIi856XX2/X4KeagEXVwKwd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178239; c=relaxed/simple;
	bh=NGBYbg7UkfwWA9S5rny5UeTYoAabz+VUvilCJzQcNqw=;
	h=Date:Message-ID:From:To:Cc:Subject; b=ptkqi0vG3ESwpswdcnqxT2Q8xgc5xzQZBWZSQRkuzqsQrieIuIA2YFqlFm0QmDou3H0pe4uzmPDf3Lx39XrJOXhOajrWzfgAp55OZaFZUjMW2r80dcxFR2R11BkQvXfKbp0+kMC2/zx5VTvbWXQ5e0l0wVZyBKw65hZcgjtGpBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fjmthoG3; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fjmthoG3"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-503347e8715so74917991cf.2
        for <audit@vger.kernel.org>; Tue, 03 Feb 2026 20:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770178235; x=1770783035; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7y0HD6pGn4U56GU3JSwAc1F4bSA91jQpSfjKPdrAoA=;
        b=fjmthoG3QLRFiOBYYv40Pq1LPDVotfGYvroA2ijzhKZeD2VIP3wm8ucPM40smXExXz
         Y23g/DPX9O0yJiqOQcxtdRaD7OYAfJN3TVdT3JSozibZabggZwNn1I3ATgrI7yQhC5pa
         7lxPtKfKz4a/bsRZs8oRP/DF0UKqr6tZLss1qFVLFpHoLBLZlZjpLK9uWo2d/e1X8L20
         I9NX4JpIIIEvIDLxpZwg6Et0Z7gntSYRrYMerqazl8YI0UFrR71LQ+p7b6V1Val8CCLL
         KJ91Lz4n3gqHfT7rkjZxPt962/5CPTboqbRGgC5U9PhdTSuwi2ObsMr081Z53dfGk4T8
         uTRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770178235; x=1770783035;
        h=subject:cc:to:from:message-id:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l7y0HD6pGn4U56GU3JSwAc1F4bSA91jQpSfjKPdrAoA=;
        b=D739KHpONe2FSbmd9QZqDQtuVjFwT+Fgr35ZzysjqqJNSrN1/aZeU6jEi0kIFeA2cY
         xGzQIIaAYlcKk/CfGjnR+aRX889QAtzVhFhy2ZFI8USaEnFcfYka3KJO7i4iWnE8w04q
         xMrO6Ob8HgntPVTAyTAs89lTjm3Va4edv4a5waOArKVw+8en/lvNIEcYbZB4Rz2Y1KKw
         4seJSpOpku11IaxcesdQ95AV83VzRZ0y//LFjkfVbFWeiuUTfsfaIWnSpLkBdFUJdOJJ
         7MJFmghHfTazbGp+r4arYxpGVjIwWG8P2GXwvR34igVK4vKWRmrlXRyP77TcQmmy+jMJ
         ob2A==
X-Gm-Message-State: AOJu0Ywf1g4RmYJoKYfskf+JyHZagZeaKYjhvSfrQHGWZ7brWsu6JH7S
	W56KbFMGBWF60ZWAVe7EsRs9Yjjk2d4Gx5yOUZl8TCfQnvggwzZ0ePsWMFUcbzvf7vChMX+o+QJ
	Njrv2Fw==
X-Gm-Gg: AZuq6aLj1iAJ5whvipR7KjxN9aIg6/0lgnmHxPaz5iL562QhI3mll3UVoMo8TLcdda0
	dVPN3BZQ7WsirJH6t5wM0+AUzonXFrs8tGXzF/abVuDzvh3mN6ta4z4VvIGJtC4UTSkTnjAV8GK
	1zNurjqRcX30MCC4L4ldpP4T8ANpWrEmID3MQdH2rRZLzmOYWi03mLQxWwQaKvvyVDs+n51hatB
	t50kMgCjerl6nUNfyXlP/us7BhfszXMZLycesOCBlIU/0B9lN6IjbMC3n7TgPzmgaO5fO7+IwmC
	M66Ndl/zdfdc8JARYE44JVdMHmu3casGXFCGIFGEOARCB/0/+rEIbH+cOwSZoBlLRNwzBLllAg0
	M70r7VUnoUE3YmltasyXdc+Lit/sP9OlYDZlAJzQ6OwwU5WgZWazlh3H7IH5LQMrI38jY8u/tUG
	9YrW5RFrNdNbyRDKJweIaCNS5Q9WG6w1J+JfCJ9bABSHqEd7CVclNq7xpe
X-Received: by 2002:ac8:598f:0:b0:4f1:de1c:dfa8 with SMTP id d75a77b69052e-5061c0deafbmr23497271cf.19.1770178234725;
        Tue, 03 Feb 2026 20:10:34 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5061c1f9470sm9076441cf.24.2026.02.03.20.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 20:10:33 -0800 (PST)
Date: Tue, 03 Feb 2026 23:10:33 -0500
Message-ID: <4d8d54dd3db528deba7eddf05201b1df@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] audit/audit-pr-20260203
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>

Linus,

This is a bit early, but due to some personal scheduling I'd rather send
this to you now, and you always mention you prefer to get pull requests
early (perhaps not this early?) so here is hoping this is a win-win.

Here are the highlights for the audit changes queued for the Linux v7.0
merge window:

- Improve the NETFILTER_PKT audit records

Add source and destination ports to the NETFILTER_PKT audit records while
also consolidating a lot of the code into a new, singular
audit_log_nf_skb() function.  This new approach to structuring the
NETFILTER_PKT record generation should elimiate some unnecessary overhead
when audit is not built into the kernel.

- Update the audit syscall classifier code

Add the listxattrat(), getxattrat(), and fchmodat2() syscall to the
audit code which classifies syscalls into categories of operations, e.g.
"read" or "change attributes".

- Move the syscall classifier declarations into audit_arch.h

Shuffle around some header file declarations to resolve some sparse
warnings.

Paul

--
The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/audit.git
    tags/audit-pr-20260203

for you to fetch changes up to 76489955c6d4a065ca69dc88faf7a50a59b66f35:

  audit: move the compat_xxx_class[] extern declarations to audit_arch.h
    (2026-01-09 16:37:59 -0500)

----------------------------------------------------------------
audit/stable-7.0 PR 20260203
----------------------------------------------------------------

Ben Dooks (1):
      audit: move the compat_xxx_class[] extern declarations to
         audit_arch.h

Jeffrey Bencteux (2):
      audit: add fchmodat2() to change attributes class
      audit: add missing syscalls to read class

Ricardo Robaina (2):
      audit: add audit_log_nf_skb helper function
      audit: include source and destination ports to NETFILTER_PKT

 include/asm-generic/audit_change_attr.h |    3 
 include/asm-generic/audit_read.h        |    6 
 include/linux/audit.h                   |   14 +-
 include/linux/audit_arch.h              |    7 +
 kernel/audit.c                          |  159 ++++++++++++++++++++++++
 net/netfilter/nft_log.c                 |   58 --------
 net/netfilter/xt_AUDIT.c                |   58 --------
 7 files changed, 185 insertions(+), 120 deletions(-)

--
paul-moore.com
