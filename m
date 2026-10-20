Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792514337;
	b=TRJqUGDpMotOfYOee9RSm2KG4XCS6vRnoY28FWTh18k7EYu63O+GGd9NO98zW5VDFdoj
	 yLXQucqrR2j2nNTcAQ+vuhUt+99trKx3Hy7ERK91zyfjmy2J3HyixEmeyhDuAGb8evDvT
	 TQIxlrn/zDdf5OXNdlLAVV8sqNIecPihawvShmPLdXQneudGC6jQu33lQTMgfFGu7NvTQ
	 mpQdVQXIyflY7FW43AmQTqGuhPI9uboCXh1myYRsppG+bu0uqlYklllTFFljyeCVV9jiV
	 dbT7TGbMKTzpbmg2CAhM81As2V+KajSwycQouTFS4o0efUgeRyaf5n74qRaBmKq5RkQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792514337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
	b=xv73eMxi+KYgVPnlnl2JpjXTE1bCLxAqACCR/M/bXcn3NeBftMy5Q/Hz1kHxhHuB53or
	 ZTiOGDgpVhIne98xtLOgj18V9dP16UbVFzXSinWe2F/YVB5ywo/do1D1B5TzCpf5lIH+h
	 ivFTbufHgCwpiC486/iL0uPqosYyLJBH7UoVwyDpf6PGHeaYSUyRU52jqLCy5sbZWM/GS
	 ce27C6V7+KFUAkTixccg2cE2MUgEmQnmyw+FtRmreizp/MFfcuG3qg7PgREo1h84Di9N8
	 /a3z3E7JNsZJI7RIbZW7ch14QeWUD7dMLL0KX79eHSErT/L2SCRk7+90xgSYnVI74SQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GwYGVURA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0178A60A2635
	for <audit@vger.kernel.org>; Tue, 20 Oct 2026 16:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0178A60A2635
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=GwYGVURA
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8b20a899fso17227895ad.1
        for <audit@vger.kernel.org>; Tue, 20 Oct 2026 09:38:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792514336; cv=none;
        d=google.com; s=arc-20260327;
        b=fShMmWA9ImGBeNLnxQjtobdk8we4eCdwPKUmQMVX27z8IutC6MCOV8hKcJKrjc+rbu
         7YqPJM51wtbG2DoCJrQlqy9j3V7Rdo7A9xh3GNRIS0hpjzL+bTxYBdL+KQ4Ju9yb5rhR
         Gicwdr5f1Otjxo1EHkSobSj8uDQyem+uDXlq04Wdfm9tvUM8d6F1a/fzpiZrbgVCYvhw
         GMxfKUyyRtiizgYol5dIBCEtqXgdRv9yVVsuv1T0HM1pWgjngIV0IjwGzN1npZGmQSW5
         kZjQNGhy9Ah/Hmm6uKY+vmD3VeujmED8fmR6jGgcGOAuv8OhvJ3noZbQTtdI4+LOSPkj
         rlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        fh=b8NH310RuesssRCaAmnBQdPTqvz9avNnbX9wpmAPCkU=;
        b=I1j/poaB0/IvyJACxWM/iaF8hA1/+f3hqrX3kNiOSJXVZOzxfsUHux32r96w93j3Ms
         BgSXg3Mw1ynpMEvGS0RWgzMtV5k4BMWQrqP4uQPrZebQUVgIbPd9woZQn/ZvJZXZjNOV
         zdoDtwd4tjNjFqUfDBQ0RjhHMLM+aSJhcRyBwYeDhyO7KDk1WHm/OxibJjQSChxrrz9l
         glJ2kcmA2wLGcCwj1oSG+7ln8fli0vhINv+oNB2/Zh7gTkpkiCuwBe232h5j0VkjXzDg
         HdmfyPFSl27gePB2Q2tTgQvPzmZvnKfTAwq3YJOuertNi6sy/+8aefYYvrxjm1z7OdJy
         Pf/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792514336; x=1793119136; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=GwYGVURAL7E3Gqp1mE6IbppA5fK/M6QVj3T4+Mu1VqNJAQWSHTCgIBs7lXAHx7VP4b
         X7Ol6JtjEVwHUVW/UUWijctAKk0S3FIF6sAkL2D0z4+yun1CiPIG05jQakKiuYArY+di
         qKUZ2JssWHS9PY4Rrbam2j+K8HSVipMYAjJhVwlz0qlw5vC30c9m2oPlM5nOac4bwKsb
         0iIOeo41vgbotndmbkqO3IW2nEL8EcaGXBwYuALkuaiWKHExqpmpd78k/kVF659++rVb
         16kcHMvBo17gh+L06xflahlYQXJ+NMSTGDwKIeHcy9Z1IKqewLhKEpxT50Ywi1EBHbtT
         Ya6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792514336; x=1793119136;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5h6v8PMV52XAIibb0bLKm7PVGjK4muo/m4wCC4Oc5nw=;
        b=lCm19hEkUGL8p8ZdkMAvS0vaTknPH/0ZsFhejb0ANd8h/4uHEKH3aF5QNrbl7Rg3bR
         /CfFn9CefqaqfFOVPG9vNzVIzVoK9B/1LubT25hOO5YmjYqNNprwpg1GN/iRI04UX98Q
         Fkgu+T5U/S4q090WNvAj1D0ZXhi2yoix01vslxO8KUVh9OY6o/aToeXnw9mMB05zr9Kk
         mm1u2ESi0nHRi+PipQUsvWATRJuw1lrUePlwTYwbmnyca0QNumPm4jvBAR3fQAzBcHiF
         V9/dfAfeFN/rbIFwHIr7st5jhgjCEQGxm8YymzRecjPP6VjHEE6qFiiECETaBaTmhxu2
         tkjw==
X-Gm-Message-State: AFq9FYJ4BWj2JqP+QM99LW5lpb9sV5iSuG9D9ddpgPw0wZxoqDpwzhdp
	5GxMzEF8ynFSEmsMvUtUdRmLuNXBY8EsIywaFR9WI6mIB2l32ncX9BP/sk2q+h+pdvDDLl93Ggy
	cm/dspYYny4/TyiYsMlIGuBdnShnosiZtDOr7fI8m
X-Gm-Gg: AYBFou1L5CERwcpeNIu5edyYNIz9b7ttbEQ9oKnHLIX4uyT3VvQeU2fwZyKzMM54Nnr
	O8mUFdRkzd2UB1Bs0jgVIRDyTMV9hY0Ai4Nv69PdnNMvLqU9By4PLnZ3kxJdM0WZHwuxpRPzyl8
	4wJe0gNII/EL4uZCTuvGTVFbRu2qr9H500eYzNbBOwECkMMo/U+LW7EVZxI9sqSGc1/FoBM9CON
	WpsC7onjqTvi63+EdiWegUfNmUdzVD91rneBIoSAGDElTOyZ4UrTxyicpKEa6cshVJX0x+NK6Kz
	E/pOcr191MEnmcIoluM4xZmwtx1v2hsnKeBkYmSQg6E5C9ysjYIOPGefGI2ojEzUrYecH4Rtl1y
	wAuwlhTUCWLE=
X-Received: by 2002:a17:903:1111:b0:2e6:dcce:8227 with SMTP id
 d9443c01a7336-2e9a6c1a30dmr99034965ad.37.1792514336247; Tue, 20 Oct 2026
 09:38:56 -0700 (PDT)
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Post: <mailto:audit@vger.kernel.org>
List-Help: <mailto:audit+help@vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
List-Owner: <mailto:audit+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1790088067.git.rrobaina@redhat.com> <CAHC9VhQ=FFYVNmQdiMsqg+5KDDrSC3SZS+H2=r_GkhfwQox8tg@mail.gmail.com>
 <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
In-Reply-To: <CAABTaaBL=TScs8Qqu3b8F6KZPGMyvwy6cBC3teDaBL6MGMucNg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Oct 2026 12:38:41 -0400
X-Gm-Features: AclHuK9ZakV6IFm9eD67kaqUic0iU1MgVPLS7VN6RgjPgTRZmZP6_X_XOYOX9ZU
Message-ID: <CAHC9VhROsmzbm+AP63Sm7mqCokgEy6Zu0AVMY0gxp8qY75Pqiw@mail.gmail.com>
Subject: Re: [PATCH v3 00/14] audit: log all six syscall arguments in the
 SYSCALL record
To: Ricardo Robaina <rrobaina@redhat.com>
Cc: audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, bpf@vger.kernel.org, eparis@redhat.com, 
	sgrubb@redhat.com, oleg@redhat.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, linux@armlinux.org.uk, 
	catalin.marinas@arm.com, will@kernel.org, guoren@kernel.org, monstr@monstr.eu, 
	tsbogend@alpha.franken.de, jonas@southpole.se, 
	stefan.kristiansson@saunalahti.fi, shorne@gmail.com, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, 
	davem@davemloft.net, andreas@gaisler.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, chris@zankel.net, 
	jcmvbkbc@gmail.com, tglx@kernel.org, peterz@infradead.org, luto@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 8:36=E2=80=AFAM Ricardo Robaina <rrobaina@redhat.co=
m> wrote:
> On Thu, Oct 1, 2026 at 6:06=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
> > On Tue, Sep 22, 2026 at 3:21=E2=80=AFPM Ricardo Robaina <rrobaina@redha=
t.com> wrote:

...

> > * As pointed out by Sashiko, when you were converting all of the
> > arches, it looks like you missed alpha.  I took a quick look and it
> > appears that it should be a pretty straightforward conversion like
> > most of the others.
>
> I've actually dropped the alpha patch as per Magnus's request [1].
>
> [1] https://lore.kernel.org/audit/CA+=3DFv5T4826T2sd0Gbh-nfZsqcWK_phdBKy4=
BLWOvDTt92t5Eg@mail.gmail.com/

The problem is that as things stand, this patchset breaks the build on
Alpha.  Perhaps this gets resolved during the current merge window,
but as you know we can't break the kernel build ...

https://lore.kernel.org/oe-kbuild-all/202610041836.6TatRQSm-lkp@intel.com

--=20
paul-moore.com
