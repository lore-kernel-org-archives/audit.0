Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GADWVQCx"
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4A719B
	for <audit@vger.kernel.org>; Wed, 15 Nov 2023 20:40:31 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-d9ac3b4f42cso1372478276.0
        for <audit@vger.kernel.org>; Wed, 15 Nov 2023 20:40:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700109630; x=1700714430; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TgKS2a4Y+P+vco+T2kdSgzh3oC28Kbo5e7LZzXJ+hYA=;
        b=GADWVQCxvRPygrVFw8IIP167OaG5knHYN32zq27oxh1gG6aH65PYVwrZ+CMUE9H5JK
         YrR+INmnuh13/hr9Wct6tpJCS+QpT5+nBc0tOLsdm+ainGuUlof3uwxsB1T17VnuhSpI
         V1s/OdMBZN36iVIq9c8PmgYVPccYGHKL54/ovQVZP0s2tHLbgZd5pnnxxRZ7NIUOvyYz
         r4onjfe3y9M7ma/HqrjPnRd+IQp3W165ySHEaDFdQ1SbKm0yONabCDC8GUwCbmQ1TJ2P
         i/UmLLeSF9yJyZEWnun3yqLtbjXKIkYA4jfrZKVXHeiwdEWE7x0hTOqYxtHyOzlX6pM3
         RI7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700109630; x=1700714430;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TgKS2a4Y+P+vco+T2kdSgzh3oC28Kbo5e7LZzXJ+hYA=;
        b=XaFRhwJHLlxSW/SRlKt8QxX20wazDDH0rGcjgcSlz23Qm6I9uIiE0vvAYoMQ1AfS/E
         STbFCT2WC+vCoZ3pks3jWaG0FuScHWwpFMA3oa6CTHKBEslLVtgzxFSa8QZIyIl7Y71B
         cLy5RWcRhXIZCMNhhfvphqaEWEpi0eB/XYmQ4UvcRYBZMmEoxJ8D2kkg0HBNypgSeeaA
         mhHFwI4YiTeHKQ1UXh5T41TV8IHC0s6zWa9X9r2JyACsQyXmdpGdiPvL5Dcn9GqhkBvv
         FDrFSOJtK3TrapFZ+pLLKSJ/sjcJy+XhmNj7yKlMSYl3s+GkdBQkOPUQcdDrVXx/jcRt
         TbGg==
X-Gm-Message-State: AOJu0Yx5Z/OjT4Y9y4dqqHO5FfAjGvfuuiB2DL+n2/Qqi8o21ZiKCn2e
	brAdGtDXR/HHoSzyCOPvbcS83bdfcOpZJHbToZljiq3oyPbEGlM=
X-Google-Smtp-Source: AGHT+IHAUj7dbe2V11Brw7DELoQLJh7tAMbrxH8er+1lzRazqdGXkTqyCJaeeieByHX9sQgImHmukBHBlwQ4zHlxfOM=
X-Received: by 2002:a25:c945:0:b0:d9d:4f6:ec52 with SMTP id
 z66-20020a25c945000000b00d9d04f6ec52mr308103ybf.3.1700109630390; Wed, 15 Nov
 2023 20:40:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115172537.130415-2-paul@paul-moore.com>
In-Reply-To: <20231115172537.130415-2-paul@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 15 Nov 2023 23:40:19 -0500
Message-ID: <CAHC9VhSNVAds99M3ew9wcu6uO1KFnNB1-jT8kvWdcxTq9d02Jg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the audit entry
To: audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 15, 2023 at 12:25=E2=80=AFPM Paul Moore <paul@paul-moore.com> w=
rote:
>
> Bring the audit subsystem entry up to date with the following changes:
>
> * Add our patchwork link.  I'm not sure this is of much use for
> anyone but the maintainer, but there is a provision for including it
> here so we might as well include it.
>
> * Add a bug report URI.  I suspect most everyone knows to send mail
> to the mailing list if they hit a bug, but let's make it official.
>
> * Add a link to the audit tree process/management documentation.
> While the doc exists both in the canonical kernel.org location and the
> GitHub mirror, provide a link to the mirror as GitHub does a better
> job rendering the Markdown.
>
> * Update the source tree's git URI to use https.
>
> * Aside from changes to the audit code itself, we also would like to
> be notified when the audit call sites are changed so we are adding an
> audit_XXX(...) regex to try and catch all of the callers.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>
> ---
>  MAINTAINERS | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Merged into audit/dev.

--=20
paul-moore.com
