Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8535F610
	for <audit@vger.kernel.org>; Thu, 23 Jul 2026 20:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784837571; cv=pass; b=LySUPtz7bqCTP/NCMuUJLjg8mWOKzrhXQc5FjM695YvbZRtCKIGalP6nCvkQNfsugf2ZN0XhRTy3ZpXSJD7KfYq5obNhKY315mRImNene4VaZE1vsGRnBl0zyUcR+5jB6WVm1kzXGq05TD3RDTidPxdyKbOKnrHSJbNc7HxyyMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784837571; c=relaxed/simple;
	bh=cRa1jnXHjfehu+vQdb0wwfICkozzEfrwV7jXJ2JhzSY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jKUa2AaoK9EKmkDjR6sCMydy8qwJq8ZaYPmx/sRJTMLVILyLiBg+SLbo/8VYJ5bi1aqZoweeNS1cqbFAgNhBpSbei0SQwuzvGmfv/FLQqZnWCj1cnDJnRpaaGyFib03/y/InE/b+4CxOovcLhYX6exqsiKIaBaXUVqq68suTlRY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NlfyWus+; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NlfyWus+"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1122024a91.0
        for <audit@vger.kernel.org>; Thu, 23 Jul 2026 13:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784837567; cv=none;
        d=google.com; s=arc-20260327;
        b=Wc5FX6NonULKl5YWtPnSw1X/WkSjDu/PUTDJZ+H3dlEFgTPBs84qKxxhbJeecqSJjN
         iV1diNqkTRbOILyQwsLXp3NchXSlZ1oj8wzL6KArkdGaR3+QKQlfL5yw1oU+Lwm/Bfx0
         CSq7yiwuLhwmojgdRN+bhexKDyj7TJsWkSGqLQpgGUOEMrYYw7jzNYxJmtgHYy0JFaTD
         TGO+6akZZ+cnAbXbUXS5c/u4dpReVehQe37q9BB/zg2Kbq/UG8YDU+c1zYfj3ipy4tOP
         cFmG2Sz87XbqrWJ4ezlSTXO1CXRcbEPwy7lHOuZOwTE03oNwJ20IbjBN31U4NPI6SuKz
         iKbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=c2R25w+oINRR/xO92ByMjiKR0FyCYK7I928sU6jzTY4=;
        fh=QBUvzydCXueJShwRyJoac18uuPW74t4ds85BWLuyne0=;
        b=iDdeViI9IiSE2RL3mF5eDmY72PtRCZ+bIlSeQQtLbTEdRaKS0LvZPXgNEj8uLiiCLd
         f1aa56/Bk3jLAhWeQ6ani3ZbVcgPVpKsd4OzAaMiIAtzLvk72LjCIzL65V3uPaSopKEc
         yilDPTLAVsmMhpBor5KjIXrSzeg7uoD9JPdDkHadfyzgFPG9OOVOj8nSp4LPiO8xkd3W
         BhYlk82V4IiXrKbB4Rz/bxzyqXS73F+250diV/Tlogs+iWA+xl4VNHemADCDAftDTzd2
         oyASCS4uIymBBZ7Mkp/aykFHjhFw65vEf75GFXcX+RP/IqTIqqmv30GYA9uhL4nNG3J1
         kyHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784837567; x=1785442367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c2R25w+oINRR/xO92ByMjiKR0FyCYK7I928sU6jzTY4=;
        b=NlfyWus+LpxuhxS+hsaat8b3rOzWFUZA7R/yq75tvcHFYD92bHQJljK3UHTGGq7li9
         WXacoO8BF5MA9t1PqCrA7pDp9yY7JCXldnJifrwrsqywCK3mzIhwVkrsBSPpyv99q4ZZ
         j19Uf1GYZFRtKAOTwOUsg/niisFF/6ZAHAeLtFWHbmy/mEkOnZySB1w2wYBLtnaS/nfR
         XZwuFinVkUqPU8bo1V+cR0RetvtKHDgVrWd+co9XpSFuuSF8i7rVuJdDl7vzgpYm4SMw
         FycqT8b5s1dmV3oGVFExc2EmYwQDSd3Ry80YCwqq4cZA6dsANAxvVMDd+8qH3yvDWesH
         xtFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784837567; x=1785442367;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c2R25w+oINRR/xO92ByMjiKR0FyCYK7I928sU6jzTY4=;
        b=aCrW/3vC+NhEL/fdSCqSpHpeY+22P0tHRPYpznEuTvCyVvS/UAhMMRyUJTcV49aAnN
         ns8qAMydX/VIKL5AZX5cW9ltJ/8K7M6j49+4jg/qCCoeU6w+7sfyAJT87yWIaF5qE0Rw
         PQb4uVJATxZ43cmGGC3vH3Nss57FXiTMxEhuJw5HzrXkINpZ+H4jA90RedmxmrDfPkJ9
         +PrlzlnZr6sWommBT9WE6hWtPYuGf6gxOAWeAL4uUQUcZeH7Rl+oG/OAQqjfcPL3ASGQ
         q1V/nl/72p9ajbHSnnldC8PkCYrWpnKoD/e7uqOimNPazCjxWj1igVjftX9C8fEOaj8A
         SY2Q==
X-Gm-Message-State: AOJu0Yw/2f1RkgKhyqZMDhiqMGTSN1Xf/DUhtu5y1U4b9IH+9vEnJH41
	SoMPXd5nyI+C7UwAcu9yUySbrKpdebjaQmH/9nlUexGqpUwM+Vk+NsDRS6u88fQkrCqnbT7vuur
	OXPNvB8K9IqzPZsup2J2G4n2vDzExxI0KsJTRqpOU
X-Gm-Gg: AR+sD136YbOTHdH+Mdb7BTbIX2dYE/gijECDlYUg8qy797nybfciAPrTBz2tF1cJ2Ec
	apTC0Lo04u2IUTgsO74b6nxWTYn+ttrDAwRnS829zk6IJkHXsGqIBnQBGH1KJ4otc7jLky8+l4O
	1pXBtB/KyoGtFZGIPsP/txH5C9pdM13F62LoPM4n/SfNjL5Y5J2OthF/+28oKECX+8vsI6059xU
	aJcRrUqIt19eHRVk0b/4ROdw1ubY8/jSYkkO3tF9kLF9RWrT5Wt5z91rf9DjKjUG49nCxoL
X-Received: by 2002:a17:90b:5824:b0:37f:ad36:8fc5 with SMTP id
 98e67ed59e1d1-38ec65ed894mr5038107a91.23.1784837567354; Thu, 23 Jul 2026
 13:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630195242.367870-2-paul@paul-moore.com> <CAABTaaCG9xrLXsYoAx9QD85t8xkpveMXi_sBndz-7mbCmpZgBw@mail.gmail.com>
In-Reply-To: <CAABTaaCG9xrLXsYoAx9QD85t8xkpveMXi_sBndz-7mbCmpZgBw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 23 Jul 2026 16:12:35 -0400
X-Gm-Features: AUfX_mx5wxE7RhkYwkiQm09t32vOdTvM3o4Wonluc-_9MEn_WEGj1iUpGhAuzxo
Message-ID: <CAHC9VhQJicGZY_xAAQgD7jOC5qFAgqAYiw5q906ZHzTY4v+SKA@mail.gmail.com>
Subject: Re: [RFC PATCH] audit: drop BUG_ON() from audit_log_XXX()
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 9:20=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.com=
> wrote:
> On Tue, Jun 30, 2026 at 4:53=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > We can easily drop the BUG_ON()s from the audit_log_XXX() helpers and
> > simply return to the caller as we do if we are passed a NULL
> > audit_buffer.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  kernel/audit.c | 9 +++------
> >  1 file changed, 3 insertions(+), 6 deletions(-)

...

> Hi Paul,
>
> It looks good to me. I agree that it was not worth panicking the
> kernel in these cases.
> Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>

Thanks for taking a look.  As an FYI, I'm dropping this patch as I'm
folding it into a larger patchset that I'll post as soon as I have a
chance to test it.  While looking at the overflow checks in the
logging functions I was "inspired" to fix a number of related problems
this afternoon and this BUG_ON fix fit well with the new patchset.

> I was taking a look at other BUG_ON instances and noticed a couple
> that might benefit from similar treatment:
>
>   1. In audit_add_to_parent() at kernel/audit_watch.c:375:
>      BUG_ON(!mutex_is_locked(&audit_filter_mutex));
>
>      Couldn't we use lockdep_assert_held() instead?

I believe so.  Nice catch :)

>   2. In __audit_log_bprm_fcaps() at kernel/auditsc.c:2715:
>      BUG_ON(axp->pid_count >=3D AUDIT_AUX_PIDS);
>
>      This could gracefully return an error instead of panicking.

I'm assuming you meant audit_signal_info_syscall()?  If so, yes, this
would be another good improvement.

> I can send patches for these if you think they're worthwhile.

That would be great, thanks!

--=20
paul-moore.com
