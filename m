Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB61DF968
	for <audit@vger.kernel.org>; Tue,  3 Dec 2024 22:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733263323; cv=none; b=Wb22bmzTs4HN9HNoM6KxAQOLnIZ4x8duq5WTCbwSxsp9X+vRP0tAnrpsbBN2VH4vqUAMXznxkaLHLA7xhVVNnbRgSgSmId4iTjbnvCIhttRGdZBHCoRpDwfx6gDLKLRAhtJ0W7g6VScod+GGlex/lBbbMNpWaWaa7TXe3Et1Fvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733263323; c=relaxed/simple;
	bh=iMjiW31JLFa/JNAGxQxIb5V7x3JFTsVdFyhdXhygqyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYCivpcnmv3nkfUCFkwHBgox9G3Yfai2BdDlsQBnkJZ714MkumtSgamDj7iD2wdPy5gscxJprtP1FjoUdcLLTA2A0dw/X6QsWJl5gbjfOr//s0dtJ3xFigLUMUv514Ifu510ym9qBOn0Jd65KeA5PZHqXL8tI5QDLIvp24I6vNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DIYnxpRa; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DIYnxpRa"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3971be41d8so4563347276.2
        for <audit@vger.kernel.org>; Tue, 03 Dec 2024 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1733263321; x=1733868121; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7U0GjbcfzhAQB9IgZbw6IGwPJ93YtDIzJ9Nx+titdo=;
        b=DIYnxpRas/702wQjlv5JEDIagTr+a+H+yIw7foToh38+Dwek4EH9nsN5usNGShJf8k
         t7Ead+7sHfBX6d1RZAC3Zs2MJ5wDKyo6wg1WfOTD1rh8hZufN1BTNK/aoE+1dspfrT1Y
         uz9DQ7L4bAbfz0UFx+hGyQsNbyOBFeffg+S3RhGGQBhy0ZDVMBUL4SWhYLp6Dg86dbYf
         BcpscCEbZIfyRB6EK48PpLs2pZ/JIx84alNykL70nLMEvL7VBVSORTtW4jUgmtGCxmFD
         1aojfnEpSkr9zF6AyIGXP2cgKtostbDIvbhXEpwA5wAIfhwYViEEHYvsERDDkwh4tuoR
         JE8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733263321; x=1733868121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7U0GjbcfzhAQB9IgZbw6IGwPJ93YtDIzJ9Nx+titdo=;
        b=g7KuaLKIHkyL2As3qI7/M5vLZg4/VRNlp+wy+Z1CMINHlpCaQu8onASv+Smb3f0+2T
         2QWs1OEJAWa1ZJmWxkoK7fzOjmOSVw3xHhC+aWmnZ1J1vuKEvEIvAUh6FAK9DtB3MDGa
         78YQGfYIb3FrjSIP1Dl5biwIb+oRDGlqMrSgYe/+wE6UPAdxQO9OPSzREKlUkAhJt3+l
         3Wbsk68NyfBZHHiFjrZ0Jpbhgx2Hp9Sw/8CcEwCiD+g1AOmoSoQghSw2eVS9UXp8ej6M
         3TlL6ZyxiysvNFY3IBtJDIzHzIJNiBztEqek3rMepZkH1C+EeXJ088ATJRKNtVE0kkS1
         MYiA==
X-Forwarded-Encrypted: i=1; AJvYcCUkBtVlUoJL8jZcwVhEAg2qUxAYpROroK4+tpkDf3s/sYdFnF0DqNUNe6zwd5IU4oHfYNRqgA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzviGRNzWedXcNMtgFAmCgnmTif2d0pNjc0H+YFRb8syk+oLoWF
	L1KApCQBjjmgO0fnG6YZ2gRPQqgFSvfcq3kgi6T0QB2diRocKxoywX865dLcSS4orIAErlw2nbv
	/Da3GjEzYQ3YM1Jj4IO0gbny8GzI6pL5lFcBo
X-Gm-Gg: ASbGnctRqCgR7i++W8YDtm7Leq8rFV1AaR4bboPnQL6o/od3GvZL/ZdLF4Cfb465NQX
	9FHNJQxdLNJ8pPb+Hd4n4TzPxy85A4Q==
X-Google-Smtp-Source: AGHT+IHZWymOeLz86ZZRjaQvg6FaFEzznigeaQilocvHe2i14UK6m1/rQtTJLdasUB2xj3FxFm3j0utddMz81VPRtH4=
X-Received: by 2002:a05:6902:2193:b0:e38:b44d:a959 with SMTP id
 3f1490d57ef6-e39d43740c9mr4105929276.42.1733263320861; Tue, 03 Dec 2024
 14:02:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CY8PR11MB713438072B901F890913803F89362@CY8PR11MB7134.namprd11.prod.outlook.com>
 <CAHC9VhR6t_LLB5nc=kqqE5FpN4ftxZYidQ8F5x1Lzowf1H9juw@mail.gmail.com> <CALOAHbCz7mpxv3Dt9jJtJJ2g=A6Nf_rn687BHgOmrzQt3Udv_w@mail.gmail.com>
In-Reply-To: <CALOAHbCz7mpxv3Dt9jJtJJ2g=A6Nf_rn687BHgOmrzQt3Udv_w@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Dec 2024 17:01:50 -0500
Message-ID: <CAHC9VhQAUfocUT08U99hWoKPM2F=J-F+Ph1Xeb49k1YinN8sTw@mail.gmail.com>
Subject: Re: v6.13-rc1 build errors from kernel/auditsc.c
To: Yafang Shao <laoar.shao@gmail.com>
Cc: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>, Kees Cook <keescook@chromium.org>, 
	Eric Paris <eparis@redhat.com>, "audit@vger.kernel.org" <audit@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 2, 2024 at 11:04=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Tue, Dec 3, 2024 at 11:35=E2=80=AFAM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > On Mon, Dec 2, 2024 at 10:19=E2=80=AFPM Zhuo, Qiuxu <qiuxu.zhuo@intel.c=
om> wrote:
> > >
> > > Hi,
> > >
> > > I got the following build errors from kernel/auditsc.c file.
> > >
> > > The GCC version      : 7.5.0
> > > Kernel version         : v6.13-rc1
> > > The bisect commit : 286d7a54c8a2 ("auditsc: replace memcpy() with str=
scpy()")
> >
> > Unfortunately this is a known GCC bug, see the lore link below.  Kees,
> > Yafang, do you have any more information or compiler-based workarounds
> > for this bug?
> >
> > https://lore.kernel.org/all/CALOAHbBB-__eyERw82QnS3Wmgi7_BpPaacY2urVmpW=
X3ZkVtvQ@mail.gmail.com/
>
> I'll prepare a patch based on Kees's changes soon. For now, let's
> implement a workaround.

To close the loop on this, the patch can be found here:

https://lore.kernel.org/audit/20241203060350.69472-1-laoar.shao@gmail.com/

--=20
paul-moore.com
