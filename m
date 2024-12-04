Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CB013AA2E;
	Wed,  4 Dec 2024 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733292516; cv=none; b=iWxozTUPuqfulLr/UXlw5qPv7EgBRKFu5lYtKv5BL3uXjEhlZIgBlxLc1jpHehnwTwIK4PV6+fES4SC8UvgMkkjlZtiCpgkqwVvVymT4fYFIyS+YT0Zh4X/X/y75ZTUT46xQ9/dBr9TMDfSgoK3yx4Qg7NsZxlToiiTpGBK774g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733292516; c=relaxed/simple;
	bh=90TfX1t6ZQ3IuFByFN8rYHKpVcuFtdHyJ88OQof+UXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uZqz9m+Hc2y0RFmoyJx4hEE6DhtEnNe4+H489PhhebMDDF/2bi3tklkah7Ap01SjV0YYdRiSZIT5+7N+k/125Sc2W8AQnpndFMooWEtj7SFrLUMsRB50v4EKchLHSsf877LVucvffegOQPDBthBW8elN3qsjKjIYiCiG3TuaLZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/R5Zrtb; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/R5Zrtb"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6d89ec77177so26463696d6.3;
        Tue, 03 Dec 2024 22:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733292513; x=1733897313; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q40kAdX69EE5V4t1OfK1mylfKNmI0uPT2IfylYiFTEg=;
        b=A/R5ZrtbOPO2pa7d8VXk5Wp1bNNYdCAsGoegoReKX9Jtrf+7kLqwJesqsiqFBrcYdt
         DeGB+fCWHX/3yMIrBFsQn/0Dp/oWKRSrUfLcuA2qtlf+cBzjsl19NDxlnFLitEZTG1vl
         1uXl6d3sw5s3gQnn5bK28BGZ26dvSw9RVNYRk6lqxBFmeQmki8NHPo4SnjBTzhEAuxO7
         NAMl6vhxOJZ8ps2QYjbI8EiWSChN0fJmqt21tMBAmGuARJUREGBJj4z5QsLkqyKULmVV
         k95zyUn704WHl9K0qZpsbyk2/b1hiHRa56E9AolhG/XjeBEj2n3/n5GmODVjzYQ5AOXi
         aWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733292513; x=1733897313;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q40kAdX69EE5V4t1OfK1mylfKNmI0uPT2IfylYiFTEg=;
        b=Ljug+LyN0JffK0xPlLAQMwKxvzdy8hWmf/0C8l3sF61s6t599aHYmuwj6XLyQBGsC8
         zdH0E6HYnoLpKOkNtSkSvJ9+ZRX8E05aMdNVEtTWOBrNGWF7i48cVnN8wO+3twc0X9fK
         joK4jYlvoj7JzDEHBZWlTVr28V1c/aCf0XPsu+AKg5PoZYAZQRBg1mdsPVQMVuBIdYT1
         aSq/RFxkvGhyAfHifRT22cOuhE+wD3fW5QUgsVTgQQhsN1fRWFqyNKvr+jaggys5Dy4c
         wVSHVAUMvdr7EVHobKkqIpgpVPoc/ZYGycie5VZQVWlRvvI+U2rnxdxhOM9sZOzaUS7O
         9e9g==
X-Forwarded-Encrypted: i=1; AJvYcCWo+QBvzj63CG7mB14Lgc5wtJoyfTY/cagMAxJ3stNq6EXZLaWOjyLy5M4URKo82YyV2lLx4g==@vger.kernel.org, AJvYcCXhkmBXlcNWub6Hy1/RIquSomf9FvYVr8FzE9fUVVAk2zdR92aRTScJxsObr2xVjW1XefRoXODYvIXuKfG7@vger.kernel.org
X-Gm-Message-State: AOJu0YziogEl3tZNUG5RCs6D9krGMxXwV0whmwrlclOsZ+dO0+hfGFHu
	LyPM9THYqs+RGR0ZbiBh8z7YPZloWNP+cvPKxI6p+K9jhnDyVtBcCxtjESWf+PYgw+RPQUK1/2Z
	u7p53ysB3Dgwv60BwjecciWX1/UDAhLmNbqI7tb9SfX8=
X-Gm-Gg: ASbGncs31BDTS2wzNud74LZoTD68GZ42PVdZzXK6bzuW+ewNBcXgqI/lP8IdD84cMJt
	VaJc6WeXFcxLVC2njdxVivS2cp4oXdifqKQ==
X-Google-Smtp-Source: AGHT+IEPJTJh6hlQ8QR1g/TICFC7B74TwrB5vjEXNoYWUa+OxzLr1mglt/xfPcilkfpZrxcpeffW7vpAZJM61V6DHMQ=
X-Received: by 2002:a05:6214:27eb:b0:6d8:812e:1fd0 with SMTP id
 6a1803df08f44-6d8b7354a89mr65439766d6.15.1733292513374; Tue, 03 Dec 2024
 22:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203060350.69472-1-laoar.shao@gmail.com> <CAHC9VhTRaX02x+KFpsxmguze3R=AAF9yjTtDxf_ghVpQ3XdU2A@mail.gmail.com>
 <CALOAHbDgb5LW+XF1_VHGpr7zcjenMwSQzOy-pTsyV3buOW1N6Q@mail.gmail.com> <CAHC9VhSA7U5D0mzg+OmGi5RpDpw-+eufyTEDtLu9m=nkMHe+yA@mail.gmail.com>
In-Reply-To: <CAHC9VhSA7U5D0mzg+OmGi5RpDpw-+eufyTEDtLu9m=nkMHe+yA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 4 Dec 2024 14:07:57 +0800
Message-ID: <CALOAHbBH8p3Xp2JdajHKWzfWxtMvgA_XTBoqi8RVUV1meveFZQ@mail.gmail.com>
Subject: Re: [PATCH] auditsc: Implement a workaround for a GCC bug triggered
 by task comm changes
To: Paul Moore <paul@paul-moore.com>
Cc: keescook@chromium.org, qiuxu.zhuo@intel.com, rostedt@goodmis.org, 
	lkp@intel.com, audit@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 4, 2024 at 11:43=E2=80=AFAM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Tue, Dec 3, 2024 at 10:00=E2=80=AFPM Yafang Shao <laoar.shao@gmail.com=
> wrote:
> > On Wed, Dec 4, 2024 at 6:06=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > > On Tue, Dec 3, 2024 at 1:04=E2=80=AFAM Yafang Shao <laoar.shao@gmail.=
com> wrote:
> > > >
> > > > From: Yafang shao <laoar.shao@gmail.com>
> > > >
> > > > A build failure has been reported with the following details:
> > > >
> > > >    In file included from include/linux/string.h:390,
> > > >                     from include/linux/bitmap.h:13,
> > > >                     from include/linux/cpumask.h:12,
> > > >                     from include/linux/smp.h:13,
> > > >                     from include/linux/lockdep.h:14,
> > > >                     from include/linux/spinlock.h:63,
> > > >                     from include/linux/wait.h:9,
> > > >                     from include/linux/wait_bit.h:8,
> > > >                     from include/linux/fs.h:6,
> > > >                     from kernel/auditsc.c:37:
> > > >    In function 'sized_strscpy',
> > > >        inlined from '__audit_ptrace' at kernel/auditsc.c:2732:2:
> > > > >> include/linux/fortify-string.h:293:17: error: call to '__write_o=
verflow' declared with attribute error: detected write beyond size of objec=
t (1st parameter)
> > > >      293 |                 __write_overflow();
> > > >          |                 ^~~~~~~~~~~~~~~~~~
> > > >    In function 'sized_strscpy',
> > > >        inlined from 'audit_signal_info_syscall' at kernel/auditsc.c=
:2759:3:
> > > > >> include/linux/fortify-string.h:293:17: error: call to '__write_o=
verflow' declared with attribute error: detected write beyond size of objec=
t (1st parameter)
> > > >      293 |                 __write_overflow();
> > > >          |                 ^~~~~~~~~~~~~~~~~~
> > > >
> > > > The issue appears to be a GCC bug, though the root cause remains
> > > > unclear at this time. For now, let's implement a workaround.
> > > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://lore.kernel.org/oe-kbuild-all/202410171420.1V00ICVG=
-lkp@intel.com/
> > > > Reported-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > > Closes: https://lore.kernel.org/all/20241128182435.57a1ea6f@gandalf=
.local.home/
> > > > Reported-by: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
> > > > Closes: https://lore.kernel.org/all/CY8PR11MB71348E568DBDA576F17DAF=
F389362@CY8PR11MB7134.namprd11.prod.outlook.com/
> > > > Originally-by: Kees Cook <kees@kernel.org>
> > > > Link: https://lore.kernel.org/linux-hardening/202410171059.C2C39503=
0@keescook/
> > > > Signed-off-by: Yafang shao <laoar.shao@gmail.com>
> > > > Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > > > ---
> > > >  kernel/auditsc.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > Thanks, does anyone have a link to the GCC bug report?  We really
> > > should mention that in the commit description and/or metadata.
> >
> > I came across a GCC bug report [0] while researching online. This
> > issue was reportedly fixed in GCC-12.1 [1], yet it seems the same bug
> > is still being triggered in GCC-14.2.0[2].
> > Should I file a new bug report with GCC to address this?
>
> I was under the impression that this had already been reported, if it
> hasn't, then yes, please report the bug to the GCC team so we can get
> this fixed.  Once you have the bug report, please post it here so it
> can be included in the commit.

Sure, I=E2=80=99ll file a new report. However, it seems I need to create a =
new
account for the bug tracker and wait for its approval. Please bear
with me=E2=80=94I=E2=80=99ll provide an update as soon as it=E2=80=99s comp=
leted.


--
Regards
Yafang
