Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FB3D3B3
	for <audit@vger.kernel.org>; Tue, 30 Jun 2026 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782846700; cv=pass; b=WlyaMjJ6F/r62QuGXE3nwfsHwDGgFxRwQHZxo9DliAOvP3RwMQD7p+xKuLTaNYbATa73U32iGyRzAADclPGHQJv9e/MDoN8lJsc4u5t4nSgSYj/C7OBms4IQVhUEOoGHJu7HstJvZ4XJ8YpFAXIloTPRhtJPjf8Ubzf2r+8aYVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782846700; c=relaxed/simple;
	bh=7ofkQ3GSVUxKhwWVfhI7HuPmOMtr7pHZHj2bVwxE0D8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QJ1orQbPNLNd1btoPK9oIayCXJmKbXTtSj3CEdsMhVF8WhIteCrqUEiy+ukf5Fo2IP8c2wAOGQI851LdE/Q4+ptn2BPajfNWV2wAppOjMXQekP72j9Q+SaNwYCdVs6JPiJeEC+rZTXYch+W/vnj71WE4VMCX0UJuxxjwv9J2VHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=D31+p03Y; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="D31+p03Y"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c99eaa1f020so1897969a12.2
        for <audit@vger.kernel.org>; Tue, 30 Jun 2026 12:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782846698; cv=none;
        d=google.com; s=arc-20260327;
        b=G7H1Tkk5e1iqqg050FLx1YJVJJH785fukqVqVWTYbVlH4e5HsTuFs6vgEp/XA/xodz
         gvtlksSwIM8eXKUFY2Te/46zWfVPsfS8PKGSToRDud7qaI5c63kskAYHYAz1llmQneNI
         tzi2VS3GymxcppO3HJgT00utB1sxQYHv0i/aCmPvAci+0kKEh3sMx7kdwW9hXCVetw34
         6S+VSnbGpTVcpc50Twv9idVY5LYBA/m+LoUwqLBQuA7gdyycZ86GT+AhQGLPqM0SLoV8
         yDcuwblpaU6qrZLH6DsikPhYCECzs1z9rpnIy8QpQqCo7Gh/gp4eB/Kagjb6chAPDa/p
         9PVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=laNCqKBCv7WIZErL+9V8N5o+AKdwygWBxAJSX8PH2wE=;
        fh=f7RR34YZSzHh7mCNTwVW99wt0sYv+O519QMn54g2Myo=;
        b=Yv0ARoOGX/L7xwNKUGmTVHcxJnehKcfD9zK/b1TN5LHlhf62VQH4Mh1khkKpn4eNed
         O0+vUzq2++non6jF04Qw0oo1m9YSto1uRFSNj5SVT7Ro9KOA7py0TkffsmeMw1tTVxXM
         2qRufh+s26XR+FJtlwu0WcjtbLST0M8MprZzlYlL9+4XSM3Xmw56JxMzD4cjhyfLvO15
         w7G0dJsjywAf8/iqU0OBLEmFNXrgPxOJLWpCfE8bbjAS3rKM0v53v5TDVwDC9otT7mbk
         hntNfY0k+Bmdsgndc5sRuWZj4LOZmHuUmpTzzhZhKQwFntehFLHqEgqsQP4CfteDEz+e
         dRng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782846698; x=1783451498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laNCqKBCv7WIZErL+9V8N5o+AKdwygWBxAJSX8PH2wE=;
        b=D31+p03YLE5ncs9BfPaHgULsT5scfNH3BlhU5ZON+t30he9KQgx9Cn52Kk5blpjT5z
         N9KVuy/cE3TznMlEYfL1G+yBQdOM7dDTIe7J17L+24S6hdcJ8YuE84VAPPbM7svmCZxN
         KNULMS0kHoB4LSxHiuYjwdDUxHZ0I11zQiwB1Ud18YCHZoJleGd+nZwWfYoFtf3k78S3
         fSrt5OBUm15aUqGKM5by4rjBluIY0MZsueaKI+EG7ovoO9C3KUi29qwkpUGUTEP3/alh
         APVjbsCinQaa4kzS2FRy2/vnXwpFb+/x7uwFs71ohrauHW5P5hngZcZscUL+FN0EvCBP
         7Xjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782846698; x=1783451498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=laNCqKBCv7WIZErL+9V8N5o+AKdwygWBxAJSX8PH2wE=;
        b=e3WFPGIQCM2nosjM7NDdnXV1Dtma/5iRQn5D8rEfez7lJsxJ/vBG12FIIMqt8S/ogq
         jVgxAIqZ/ygcM3zp54yOrgEnQeVm+krSSaa5SAYHSwkSE9Pq5GsuNCjwWqEoZEeeOUaz
         rLyCELLm7L6jtoHxG3JZNnjeutvJdpcjMCvnUU2C5ARmOLZGbOoLJk/emOyiIQZL3UiD
         SNbHmyvOiPsUhEw0vPK873CpdX0l+VM8D/xr5hVX745qkXlDbMqgkOslZhNk+885GqVi
         cRV60UnmJ547ectld62GpjIX+DhjABu6sz0CahlKgzKu4ct1a/XaxhBjOtT0uc97i+Aw
         o6VQ==
X-Forwarded-Encrypted: i=1; AFNElJ9xgp9JWjHieHwik1L2Jj0gXePZez7fHCgU51//JlMt5JDX6BolXbv0OUkGSLQ6xarxhCfKHQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwH1624RHkKhUtO8R4+iarVSLoqKGhKiTZFOZt6p1QliWMcTVAM
	235EmWSb5LfFPwazhSksHT7usCeuHCg0m2+N4shjjCUNPXkb3pOWdRwfh852mav1Z342uHg6tG8
	kKrdq5AbcWy4tDmYy+FBIfkQMNRQ+QE8UIFpUmWwK9ODCYTlXHk9yjw==
X-Gm-Gg: AfdE7ck2h5QcLBMz930ojmbYl/MettddN26uznC/UzxEWdWg+iRV1R80VruomJJcEX6
	dMtZUFTEnM0kv2KvEk9fl5y6g/kNvVblVk9FgSPyqAfVuXLiHFcfVPLpUgmKtyn1OeYoghwHGdK
	bpvCkbaepd2udgQcNgs/50a/AC3ooTlkpDQX3lHq8rC9c5UlDNmLBd5yOyPcinMOdUM2V/SBxFy
	kvOQfLu9+BynanP6ordRSl3LhDN1gMgMLSKZbHnaXCXsouHikgzfkzipMTAqsC9pRqySjvt
X-Received: by 2002:a05:6a21:1505:b0:3b9:545d:c006 with SMTP id
 adf61e73a8af0-3bfc50acb49mr4413477637.15.1782846698565; Tue, 30 Jun 2026
 12:11:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
 <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
 <fce0a701-ee58-4cb2-b34b-8aec26aaab5d@linux.ibm.com> <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
In-Reply-To: <09e72f42-e180-4e2b-b379-92b755792a2c@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 30 Jun 2026 15:11:26 -0400
X-Gm-Features: AVVi8Cf1nsSKuy_9YWh2IlQC3bpng0jPtGHCEl0sgh0IF3sjPWyFNyFPXvkr2NU
Message-ID: <CAHC9VhTzuO=RFtrUUuZyieVdkrM5H4ZCb1=PoL-oEEgiw38azg@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Eric Paris <eparis@redhat.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, linux-kernel@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, audit@vger.kernel.org, 
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
	ritesh.list@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 1:42=E2=80=AFAM Madhavan Srinivasan <maddy@linux.ib=
m.com> wrote:
> On 5/13/26 10:05 AM, Harsh Prateek Bora wrote:
> > On 11/03/26 12:49 am, Paul Moore wrote:
> >> On Tue, Mar 10, 2026 at 11:08=E2=80=AFAM Christophe Leroy (CS GROUP)
> >> <chleroy@kernel.org> wrote:
> >>>
> >>> From: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>>
> >>> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> >>> targets") added generic support for AUDIT but that didn't include
> >>> support for bi-arch like powerpc.
> >>>
> >>> Commit 4b58841149dc ("audit: Add generic compat syscall support")
> >>> added generic support for bi-arch.
> >>>
> >>> Convert powerpc to that bi-arch generic audit support.
> >>>
> >>> With this change generated text is similar.
> >>>
> >>> Thomas has confirmed that the previously failing filter_exclude/test
> >>> is now successful both without and with this patch, see [1]
> >>>
> >>> [1]
> >>> https://lore.kernel.org/all/20260306115350-ef265661-6d6b-4043-9bd0-8e=
6b437d0d67@linutronix.de/
> >>>
> >>> Link: https://github.com/linuxppc/issues/issues/412
> >>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >>> ---
> >>> Venkat, a test result with
> >>> https://github.com/linux-audit/audit-testsuite would be appreciated.
> >>
> >> Yes, I'd like to see confirmation that the audit test suite runs clean
> >> on ppc systems with this patch applied, and unfortunately without a
> >> ppc system I have no way to test this myself.
>
> My bad, this is a miss from my end.
> Venkat is already on this and will update the results here.

Do we have an update on this?  Maybe I missed it, but I don't recall
seeing any test results.

--=20
paul-moore.com
