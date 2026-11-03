Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793739497;
	b=zsiozarfZeWa2yhpmo3sVwelbMbl5+eWFA0Ra2Ns8s1cku7ZYw0L6se3QYZLKTcFjZle
	 3RsVDd/ikYqOsBptJlGd5OGzJE+orGDk+ywPl2s15nHObbQA2ER76nqZkMxomrk45bFXa
	 7E1ndHcZMNO5+tRsI7VhENKHlmebFJUj9gR6h30zSDPqnlnEyx/TFev+dMrUlEY2KNQvp
	 VP3GdjhM4NgveNwh0i2WDKpJBemDUZs0zIM5qazaSErOcbbmpLRYsfiDZL7Zvgc+gOBUq
	 AHZitmPhI7cnTrKmJDWlQa6qYcMbhgUbZdSGofXyMebjLqXvxI7/jCqHrycgcaD+fPQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793739497;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
	b=QykgIY4/c28wrhEntDdIcZMSwtNjLmEJVBDvqGwBMbkg4UbrUu31lxG/egDdhp8ZnV6q
	 v3wKKJ4+PBoH6jOZmSCE2l7hvu/yivrQctJnO11eDN7Bqxykqpyl4cdWmXdttdwOBp2dy
	 ftkmH0MTKklU48O+i8M6tpE4jQLWjOuWJUueroLD2pYJlcKgHKXIJnV77ZPOz6ycH7MJ4
	 jGtc7cUAgLlUkdrno23AFSzuqlWUFCdiAp18txi3EYhs3WfY7pAmFPavXXWLjGVz/eSzh
	 rF+tqqcxWXh5RuugYP3/Qud7EgMKNgVQ62ZUzoscXEgz86FOae7DhNvIBJeoyFO5lCA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=gNjU0kU7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA3606A324
	for <audit@vger.kernel.org>; Tue,  3 Nov 2026 20:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53FA3606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=gNjU0kU7
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e9d1114320so36642225ad.3
        for <audit@vger.kernel.org>; Tue, 03 Nov 2026 12:58:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793739491; cv=none;
        d=google.com; s=arc-20260327;
        b=l9dHb1SIfwcZys+tEHxWL/zohJMUCd7voLGyFi6lCB3cgGcOpRzlUlmSFky2dD2NF0
         t/b/ybyZ6LJYdrOQdHDmebl+08sZJjocl8JtYiazF/U7nvQBSA7NfmLZFY6i4t6HhjlO
         2XLSmHHMcj/U/5PToBnkCi424wUDGvDhcuAOR+EBm+vfyh1oRsDnedYfoWBHVgUJrT1W
         cGSdGNPgcFQjK4d2DszVKiukBQHzWT0Zn4wGi9wpKY9tJ4Cl2fHHXRoItOxGjIzaQNbL
         qMc5h62tv7GgF8ZEQHjb/KjPyYw3rkFGyjg5S3k7rMpRxZ00V3hWJqEJaZOcCfLfHTh/
         QcOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
        fh=UPCfqvbFi/F/SQK4yBN78qqYO0pqb8S8dd6F5KbjcSI=;
        b=RWmvH2ni5IaXL8CW0PqrGMxPBp1Y2FJgpa0pqGB2sytd9lAsJLQt9QkCpLVjuGi30Z
         1/x4H92rZpPIT6Y0kTgjuUa2mcmLHWytJKVKf+3uWLivuaUKTB6cLDegSIJ+E8SpBgyJ
         5GP0iyNYxuMYimzFZoLXPHFElVnSvo1HKPc4XT4/NnWRz+XMafIhUTfcHHc+zBNi2mr2
         9UPlCq3+BOWThEt1mmltb2FY4Ss+HmgwmrqZZV1FbHDOAxPYkonpMZhLYYoVzuImHSKQ
         M/l9iEh/Hrra7j7YhhfszX/jpyoeJHr3Uhj4DrHhYcSFUCnbAjALXN+tj+cDXnikdd3S
         4XIA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793739491; x=1794344291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
        b=gNjU0kU7sM8uH5XC2H7b99i0TvtIF03FfKAOB0NH5+8azPBEMvKw0LopoHo9aDtdiz
         VDyjVtVrUAN//DSQQ5olLEEOAjJMZhga8ZmFPcbKfD2Ft577yKe7V/QcHq6FX9oHF/yn
         3bCew/1NgBdXPqXDNjd/pB+bgpfklJXpLzQeRdEu1INssd8arH3ktroB3iBaNXq5+ufX
         l8KdXY9cOuOdz7Ack0IyhbVI7+narclszD/zONZH/1ebAaSxDxVSg3gNl50MRCwl0e2m
         B4k3pyP+iT+yfzugI1Wl73+2lNHj1HV2Ub4A50Y+lzMd9mZvMR/+dyBS5pq+lnHK5qZV
         pvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793739491; x=1794344291;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xlEVARhdYpI51yqwMKIfAYo+e0yxy9kuj0dDIqLQxSg=;
        b=dxOOcLBGc1T2TZV2RGFGGn31GCi7cOOjygxKwU3VIjOQanzZ/zatQG19xzlOgu7wKw
         HbUyLjmZiCHCHyAyZdpsgs39GoVUlYPKyoRQWLest3tl1KSeMyy5iPPqat2WTQ8C5o99
         MSNArXyQPo/MoeRaksJcDq9BZ4A+IR9dTPqIP4/rNlVH7TtOn2JqmQuSo4WeSbdvLuRW
         y6f/8VyvjOjaQnDUgbI1Im84XDd7p0SS0HB88LWNIo5DCEqdOrlNdfS4LLbcgzr9p7IL
         n222eOxKL3QEHES7xjPgFvqeBDX3FPDVVsvBlwDUU0zkfcJb25VlPb1T670LEl3oKf66
         OrMA==
X-Forwarded-Encrypted: i=1; AKwUvBwvjs7PnpWXsXMCzGkXjx38jUXgKe7sekzG8JVOdtl4ggWWfCAEkYBFunuWQeHfWyIHZuTPgA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9U0zbryLCwy6Fu7kqdqEXTdvXGNLzw4jMKwjpvMgYk9eER23gb
	hszGsIUia93b18UrMDeOGqSGbcHBLKzNd3qR+wEw39lnSkRCEq+sQdOOr0DbpCpTR15RYopOpqh
	yqfkmZpX3dAE7d8PHexR0TxFoj3q5FpJuCF1ElQ5J93Ci9taFeUVCKQ==
X-Gm-Gg: AYBFou2z8x1cAfo013fquTJ2dlqD2ND+kWVimgkGqcm3gKLjACfdk8Bm/v7Zl8XXQfa
	ioFzM0ugdkJWJXL5A16aNN3+yhnWTO7xEwKTZJKXaxhFYdzmzuEeC7rzvmtHYkn2UNcDK6qBh/c
	lzd0+r55D65LcoHutrj2KfBM7h4pNC6cOJNpOfueJVf/fEIZ0DOebRk6w5VfBRBWrvx3cClvvOz
	e4cBfxpQksEMX1G/0Wm+B5c+IVed6G7/8RsdzflZF4FxYcI6wFuvNH/qK/uDQs8G0YWDngh/rg9
	S5xgyJEt8TL3XKgqINZHW0QpJgKkT/FLSTCzQfe+DUKrqBGQe5BPJlOTLHVSroZls7osmEBS23D
	4FW3YA4iwpkIwGrb94U5qtfBdz1NLMJoIEWHHuqIhS9Cmpu8infXU3hyk2a2aPdnmhD5B
X-Received: by 2002:a17:902:ce81:b0:2e5:cb1f:898c with SMTP id
 d9443c01a7336-2eb364ed0f9mr139787525ad.46.1793739491564; Tue, 03 Nov 2026
 12:58:11 -0800 (PST)
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019222858.1766-1-drifabdelmalekmohamedsaid@gmail.com> <CA+xk8n--qQfYro+xsGu+z7nuCrAJgwzOOyrc+iXuBeSsPOWjhw@mail.gmail.com>
In-Reply-To: <CA+xk8n--qQfYro+xsGu+z7nuCrAJgwzOOyrc+iXuBeSsPOWjhw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Nov 2026 15:57:59 -0500
X-Gm-Features: AclHuK_j1m1BaQJmY5Z4xSDq4UylbUple31snnL4So3-rHmuEym2QzQD59EuRAE
Message-ID: <CAHC9VhQzeCgCx9mi6pvbQKLH=P8b-o6JuxeUo0QfyebVGPdXGQ@mail.gmail.com>
Subject: Re: [PATCH] lsm: don't call d_path() when current->fs is NULL
To: DRIF ABDELMALEK MOHAMED SAID <drifabdelmalekmohamedsaid@gmail.com>
Cc: jmorris@namei.org, serge@hallyn.com, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+975ace299d6ba2eb1cea@syzkaller.appspotmail.com, neganhat@gmail.com, 
	audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 3:18=E2=80=AFPM DRIF ABDELMALEK MOHAMED SAID
<drifabdelmalekmohamedsaid@gmail.com> wrote:
>
> Hello,
> Just following up on this patch to see if anyone has had a chance to
> review it or if any changes are needed since we're at 7.4-rc1.
> Thanks,
> Drif Abdelmalek Mohamed Said

[CC'ing the audit list]

Not yet, but it is in my queue.  Regardless, thank you for the report
and the patch!

--=20
paul-moore.com
