Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4810B25A2DD
	for <audit@vger.kernel.org>; Thu, 27 Aug 2026 01:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787794966; cv=pass; b=f6Y7+LbtKQS9CQCUk+vnOd7EztQ5eFM7YvBqvHkxL92J7WhFnERU6Ceuj1uLgnpOxBZlzRql1mZYtE/KT+MlDNSKii2GBZW7wu8r8XSNzGAsowgjm2ZMjpBIaDPKna7X2vbsR5z0HFmmRohEkr9f6ppGMr3/KTIKn8Abkri2Nf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787794966; c=relaxed/simple;
	bh=jQXZpWEa69A8mhfcE1SS+n9nS7LZ88iDUXIZo6zOxlc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U3hJxrJe/Kh9oo5dqH7wbHWapy3uxj3JpY2hAVQUDTBpLvUsesEQY/7c2MqVyJ9eb8DxM1eEPVgvUj5uc4EGENfLmHbat0svAxmpoD7vwrgR7dpmojYfCAZ5vHq/zdW/npkKMbfhQLz8nlZJ0xMX+TucjiodHXhGRAJcrwbbgIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WUkkzwSL; arc=pass smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WUkkzwSL"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1485873a12.0
        for <audit@vger.kernel.org>; Wed, 26 Aug 2026 18:42:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787794965; cv=none;
        d=google.com; s=arc-20260327;
        b=CKJGndxnSQ+89xom6E26nCX8XS7pB5VuaeBI/0k0BYy8wCIGjNfQpXAW8L+GIvWhhe
         unOI0xeKwluAEJJV92zX6FMlAEcn5tymBmDsSwBpC0lp0IgXzvM2WZz5yg1J7abgUovL
         tZJEGt6jEulShF1eSMwoaeC4RwZBVqZP/Yge+sxiBq+gdSPUq6ofMi6XmdYXfkrE6hc/
         do92jUnJOIeYukoUgTT+zXM+ABxATaKAP5C/cj1NN+w+KqrPcSPLjXiI+pB38cwybBO7
         jDwbHUjfWNAoeEjn9mscPTdJOP2MSg9QG+aBtFZkK5wQlj3DR/l/QMTeqrZ/eg3jgamV
         iOJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MW12y6xPgbaKCNUYBedVgTiCqU80qClCqNc6nnpgicY=;
        fh=Ndqgwvk5413DjaXd0/eakH6ecmR+ziRGRGeTWONY92o=;
        b=VIhpeGOcWPcTa7TKY0h8X6ggj1iOsjktLIOkPS9ktZPNli4x5qlsKLsn/yk1W02n3J
         0fjfPp63pXWYl4ms+O8ouJdhkOGDc34RwdX2HBDIOLsvFv5irtnTiWCEIg/ZWIpxWz3s
         XGgq4b0NZmlwzmcdd1n/ymG1UFuiaFGZ34mdwffmBuEi7SWnTLd/Fv/KeMJO6H6HXGmr
         E+koL5kjeek0ysOzfgFogypyyc8Lv+iv1d9IH2bo8redk2SeBjQ/lcplBb/4+PoDazut
         XbjP4K/Y4+C5szof1yUrjfjgskuwOHHNwYL1bcsWdUkhZA/wKBhpij6rZQi2C+iwvR6T
         vk7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787794965; x=1788399765; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MW12y6xPgbaKCNUYBedVgTiCqU80qClCqNc6nnpgicY=;
        b=WUkkzwSL7c4v3IpPSPmt1VB6GOjcx4j4iCuMchKTUiu6UpAEWXQJUS8d0C8DwWy4RB
         jqMVETOAQuIhP5N74NuSXmdPWooZtIWT5IXQruakCBWrnMhja30h8IhJ8Ww9C/8lW/7L
         aAmpiOTayqWX1YGWwHnOJyEFPygbADX1wRCfLQbKFOynryAO4T6wcVTkStutEAMX+3or
         /3/BdJ6eit5xsi4iiGIsxS8cUMZySyv/MtNYHGOqMFF7gu0mgH3BqDnj7IefJXaRttDL
         FCtLzws4IzPSX4HRktfw/PiWqo5jd5t6/YKXsR6E4EHwGc6z0XfKNegSzPCoYe4ni3g2
         FQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787794965; x=1788399765;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MW12y6xPgbaKCNUYBedVgTiCqU80qClCqNc6nnpgicY=;
        b=pU3i8klvPGKCkOt3VubAczeUnkQXK91Y/i2YxMn6YkMCBcnD9zZkTa+U4HfeMrES+U
         gx79r2l2ez7p8YTzil+uGCsmuypmSO6PWnXL+dhE1RoHjCPkkHXgm9PQl+3c3u2WestV
         dD4LYuEi3ccfY+8pMg3JFLYOVoDD+LIsgcBmRGOx/V41O0ECUtuVhvMo0Gsx/ipuaIJ9
         dLYSlLx9/bWwbHKJj+hAfdueYRgXGPEmazmRTJAiAJCHkvphFRUXsbQeF6Ar9H/dUbXq
         /I272rN+Imr3/stZ92ZPs+cuFksFjb2luBixOjER16BOIFyOfD0sqn5w9aUe9nGrPjae
         dEhw==
X-Forwarded-Encrypted: i=1; AHgh+RqzTYSDqA3MhE9+Q/ltVu9HGWhavMZFW7fthqJqaydDL8yZaLeb0jEI45kyy3HWmgrGfA8aEw==@vger.kernel.org
X-Gm-Message-State: AFuF++kDenYpRm5RUHPhXuM8R0CeQCl02B+tBnyIcuo92S5vRi9A0Q8d
	19mmTT3bRGOtXQziW8KCAA3dvCfpDYwuK754ZTpHz4bLlD/qGWFAlhANoxHQh0PXIqKulc1KKVj
	Gf72/9U8H4TPQiKCuaf469ewyIV/+FAm1Cz/HUBN2
X-Gm-Gg: AR+sD10FSNbA6NZZqHIty6im740lVZwZ+aH29xSxZOLvCNw5vr07Vs175ZmFnV1nH6d
	vlBbDCXVHSvbgGupMiKkG3u/TEXLQGooB4notj/a/LnhQs0KeMqXiXf5LxkcdOSqHXg4+tPAcDL
	XGfS+SfTbEBPt9CQnFEitns1Jg/ZbqvPBMBgL9pv/EXWNlTXzAbidxcoVipT8FEe/P2L19f3lFm
	DG+HQeGlG9PQsdhWGV5JtWnKlCRUWvq2O7KZlVOo1/G4S2oNmIGrSeZMXVbYQN9elNcwuMSnSNd
	wHiWRLBZtisiKDGyvzOpYplaOX2LTK8HExeDIB2lCmSL
X-Received: by 2002:a05:6a21:9202:b0:3c3:64cb:9b99 with SMTP id
 adf61e73a8af0-3cf76283ed6mr24475298637.6.1787794964690; Wed, 26 Aug 2026
 18:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a8f89e5.1d9ded08.62e62.00bf.GAE@google.com> <7F4D890F-C006-4855-888A-62ED786A32ED@mainlining.org>
 <CAHC9VhRvoDkJ0Pn1WHgTAEJ5RwZTmD4vChFGgqATn90C-Aae+g@mail.gmail.com> <1129ADC2-8838-47EE-A817-87631D933BA0@mainlining.org>
In-Reply-To: <1129ADC2-8838-47EE-A817-87631D933BA0@mainlining.org>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 26 Aug 2026 21:42:33 -0400
X-Gm-Features: AcwNN1UZQjdl8nAFoKRE5OXLt1mXTI6xe4mUlw-2BQCvwnerelt_uTfOeFp0llk
Message-ID: <CAHC9VhT-SH8ci5f4cEGafAub4qE09KgWPJHRMgO_Uhwca2c3Bg@mail.gmail.com>
Subject: Re: [syzbot] [audit?] BUG: unable to handle kernel paging request in integrity_audit_message
To: Bradley Morgan <brads@mainlining.org>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com, audit@vger.kernel.org, 
	eparis@redhat.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 9:23=E2=80=AFPM Bradley Morgan <brads@mainlining.or=
g> wrote:
> On 27 August 2026 02:22:17 BST, Paul Moore <paul@paul-moore.com> wrote:
> >On Wed, Aug 26, 2026 at 9:06=E2=80=AFPM Bradley Morgan <brads@mainlining=
.org>
> >wrote:
> >> On 27 August 2026 01:50:45 BST, syzbot
> >> <syzbot+5ebeb3089ea6439c37be@syzkaller.appspotmail.com> wrote:
> >> >Hello,
> >> >
> >> >syzbot found the following issue on:
> >>
> >> #syz set subsystems security:
> >>
> >> Note:  here's my suggested fix, in security/ima_appraise.c
> >>
> >>  path =3D dentry_path(dentry, pathbuf, PATH_MAX);
> >>  +if (IS_ERR(path))
> >>   path =3D NULL;
> >>
> >> apparmor and tomoyo both IS_ERR check their dentry_path calls, ima
> >> is the only one that doesnt. NULL fname is already handled by the audi=
t
> >> side
> >
> >Thanks for taking a look Bradley.  Adding Mimi, Roberto, and the
> >linux-integrity list as the security/integrity/ima/ima_appraise.c file
> >is their domain.
>
> np man, do you want me to submit a patch for it? or nahhhh

That's a question for Mimi and Roberto, but if you can put together a
patch without too much effort it definitely couldn't hurt to post it
(make sure you post it to linux-integrity).

--=20
paul-moore.com
