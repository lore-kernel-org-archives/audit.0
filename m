Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20FD53C7E17
	for <audit@vger.kernel.org>; Fri, 10 Apr 2026 21:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775856863; cv=pass; b=LgzF605LCppq32Z+HUgODNPQDuujacMuSHK9aY551dVImPsIImThmccgB863oKf17zHaPosMlsVnDbqebY52A749S2xi98rzD+xadkP6BKlgNocyK+DbcnMUo8zVBGjGEEaHla0E39kOWyPCChuvl0KZ8YM3W2AQvj2PTSLgs/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775856863; c=relaxed/simple;
	bh=rCHPpW4pBeY/hAAE1d4CFC1ovoB82ibufrzuUJVdmeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fmvPBEbgaKSrHLiQxWpLRSwyz3+8D9w3uIf4NMekXWY6szTJVB2KCZNT4LzPwaduvtiiClBgtla1cB9w38Bn8TZJJl1QgstKBlw6TdGcpfBjOGsZJdv7hplEmhbAz5/7F/lstwLI1Odz8ks12ZjlltN3Z6uweIJSqGKJGTuUaJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eyOpyGyo; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eyOpyGyo"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2b2589c26e3so23498325ad.1
        for <audit@vger.kernel.org>; Fri, 10 Apr 2026 14:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775856860; cv=none;
        d=google.com; s=arc-20240605;
        b=QpN9HXgts0M0T/mjmNaDXhpmP7egJbLLZep96P1sNPNdHMGoVvbvsufo2DAy8CnH79
         axQxljF7bpmPpGLC5xX/dsHLFUoY+86y6ZmeNT9gGJ9rZV+hB9MxSN57DSobDC00YhYW
         F4ZA2umznZrjbcBCfQeZhdfdfpkP9C0stVlUzCzB87Tx3daMnYHXf1pqhHUTYx+iyvH6
         hsNVFHJ+r8mEDVBk3TmqtJ8WMR0fZOcs/sYW0tLngewLYKp0WPufUMpI8pAS0YN/oLLZ
         6I2Oc2/fMpPGDDzibgyJhjxlz+fHs4FBseF90XSZpxscJ9jbhunQfpx9b2NQZE9tbETn
         xBBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZBTz/n2iK2krJfXXDUHECjvOs2cMh613gVJ0BbHB8uk=;
        fh=9YiDhQQuGtXudNzVj0W9t/0r91nNppahqdMj9yS/MS0=;
        b=V5JMJLf29Op3g05ujL/t2kaqo2AMmXAoeOtzowRYfhX3CoSNzJ6Zty64AZjCRRLyJG
         59CyMfV9BKqGx3FbeznxBBs7bRnk9drTJUWn/RQ1xIRgDpmw+BzNCQFwFjzFpRhYVII4
         tp0qYidl5o1o5OxEIz4pJvfw0JY+O83U3lvz/PogYyr5bP+m7tzQQBMBRRxnnslWpedr
         FszQrfiQZOuQJAraF0yCz9CI8kmZmomlCcmMqG/MLOTBZKViOEnLfrMVngZH+5Wtfduo
         845UFpusnnOu9tHoek/if8H5aORFOIAqYAdbnbPM6rkAz2htXz+tmqvsIuAFniVzRVz1
         7OvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1775856860; x=1776461660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZBTz/n2iK2krJfXXDUHECjvOs2cMh613gVJ0BbHB8uk=;
        b=eyOpyGyoyukdyJyJpCXSQkUepLCQZIdPO4K9caz2tugZmJ2qOFJzsEYdW/jMnNPZau
         MapgeBkVxOdm+fSoicx7IyvpL6IzcswMkRdod39ShKuYqnQZQAWbF0mfNJycdmvYe8tS
         sP+MuSOgEW9H8JO3y1H9rNk80JFA1kK1vdtmYf52rLdNr3upjZ1Ddjp1e5dANh/cJ6ME
         9OeHa8AMi401p5rchc+IfWS6qtLdN868owj36YPFQV4a94R3Lp1yh/u8apqehDD/clNm
         XDYcj1he6YPf4CJtGFhlXfPchpR6kONyahVrlG+xBZXhMRRN4fWCzKUF0Sqc/1f2O/5p
         TVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775856860; x=1776461660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZBTz/n2iK2krJfXXDUHECjvOs2cMh613gVJ0BbHB8uk=;
        b=laT8aJ+8d+gGm0CVkghChXbf2tPJNhzUhlK7ShFPmLQMYFEkrdpztGqKJJmnB6Bm8f
         al30EFIT/WN4M7/wuza8QNoKTPk1G5KzJa/czenL+ZqUksPkyTJkRoctCRHdD3M8zNur
         31bWm2kFiTZOQJhr5rJfBU3zjgc5ZtWt+sKlQIXxwRqfdm//XRLgqxMCa4Mhk6KRI0Li
         3dkRXOWOwsX9s3Mo19nabYL8E5qIE+GX1Yi1fDfG37kT+mHJZjSS9x6JFIaD+WbAMgtR
         oMLq1Zc+l3mDsHpxKQRZpFrHEB5MF54oAdsNJGIWmL16tbbblHY+jA8Fzb7KxMpx6dV0
         ZygA==
X-Gm-Message-State: AOJu0YxtFZEdwlzXyyUgdi4Sojmwkw6MO+Yk108aI1akqAfq8SviNe+p
	m1U8oT8lsCZMAdNrQ+nKAy4bE3lFrmFuyDUt34UjyC05VzDtfqiPJQc+N2ToKWLTXjCPbBLIKR7
	cp3MXo7IRzvFOzhE6Y+WxVu/4WTJ96VzbhaeI4W2k
X-Gm-Gg: AeBDiesNtxEGaW0CvNJG/GxzhIHU/CTHiTY/DCBbwhYQYTo4rmSTZrKu8sDTBVCbbgl
	lPfz4Onttq0Vez2eZS/c0MhvgddJuBvn28XY2BIF5/pTc6To3EH5plbSUl3c7Avk2OeD/5wMLuS
	u8nce6duws2RsC1zE+m9DKniObldHFK6nAuX51OX9GNKa4dyJRAlyZHqIo0IxScU0kyxQPRvOZL
	8CLaSDtqbJFahD+xcD6vSDreJy3pto6PvMdgkLq49tuMCxk5cjNKX9REWUzafcTGeBv0HRlwCTw
	5yNWgJKNgYNFcKr7hg==
X-Received: by 2002:a17:902:7884:b0:2b0:643b:41c9 with SMTP id
 d9443c01a7336-2b2d595c808mr33693815ad.9.1775856860535; Fri, 10 Apr 2026
 14:34:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260323150700.614139-1-rrobaina@redhat.com>
In-Reply-To: <20260323150700.614139-1-rrobaina@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 10 Apr 2026 17:34:08 -0400
X-Gm-Features: AQROBzAZQv4zxN6peGHpsUPkTNxJJ_eYPo4HdttdLtzvW3raZ0Fqmbb9CU1A2Gw
Message-ID: <CAHC9VhQTGfuOYev_UNzwSqUoYX-y+RYyMZgWWG2eGzM62eVm9A@mail.gmail.com>
Subject: Re: [PATCH] audit: add backlog high water mark metric
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 11:07=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.c=
om> wrote:
>
> Currently, determining the optimal `audit_backlog_limit` relies on
> instantaneous polling of the queue size. This misses transient
> micro-bursts, making it difficult for system administrators to know
> if their queue is adequately sized or if they are at risk of
> dropping events.
>
> This patch introduces `backlog_max_depth`, a high-water mark metric
> that tracks the maximum number of buffers in the audit queue since
> the system was booted or the metric was last reset. To minimize
> performance overhead in the fast-path, the metric is updated using
> a lockless cmpxchg loop in `__audit_log_end()`.
>
> Userspace can read-and-clear this metric by sending an `AUDIT_SET`
> message with the `AUDIT_STATUS_BACKLOG_MAX_DEPTH` mask. To support
> periodic telemetry polling (e.g., statsd, Prometheus), the reset
> operation atomically returns the snapshot of the high-water mark
> right before zeroing it, ensuring no peaks are lost between polls.
>
> Link: https://github.com/linux-audit/audit-kernel/issues/63
> Suggested-by: Steve Grubb <sgrubb@redhat.com>
> Signed-off-by: Ricardo Robaina <rrobaina@redhat.com>
> ---
>  include/linux/audit.h      |  3 ++-
>  include/uapi/linux/audit.h |  2 ++
>  kernel/audit.c             | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 36 insertions(+), 1 deletion(-)

I sat on this for a bit because I wanted to think on it for a while.
While I agree audit could benefit from better statistics around
queue/backlog status, I'm not sure a single "max" value alone is worth
a bit in the audit_status bitmask.  My concern is that the max queue
length only provides a single snapshot of what the queue looked like,
it doesn't give any indication of the average queue length over a span
of time.  Some audit users are willing to live with occasional drops,
and the max size doesn't help them arrive at a good balance.

As for the users who can't tolerate any audit record drops?  They
shouldn't be running with a backlog limit anyway so the maximum queue
value will be of limit use.

--=20
paul-moore.com
